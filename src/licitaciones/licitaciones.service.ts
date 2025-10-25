import { Injectable, Logger } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import * as fs from 'node:fs';
import * as path from 'node:path';
import pLimit from 'p-limit';
import axios, { AxiosInstance } from 'axios';
import { CookieJar } from 'tough-cookie';
import { wrapper } from 'axios-cookiejar-support';
import * as cheerio from 'cheerio';

type OCDSDoc = {
  id?: string;
  url?: string;
  title?: string;
  documentType?: string;
};

type OCDSRelease = {
  tender?: { documents?: OCDSDoc[] };
  awards?: Array<{ documents?: OCDSDoc[] }>;
  contracts?: Array<{ documents?: OCDSDoc[] }>;
};

type OCDSResponse = {
  releases?: OCDSRelease[];
};

type DownloadOk = { url: string; file: string; ok: true };
type DownloadFail = { url: string; ok: false; error: string };

@Injectable()
export class LicitacionesService {
  private readonly logger = new Logger(LicitacionesService.name);
  private readonly base = 'https://api.mercadopublico.cl';

  constructor(private readonly http: HttpService) {}
  private readonly mpWebBase =
    'https://www.mercadopublico.cl/Procurement/Modules/RFB';

  private buildJarClient(): AxiosInstance {
    const jar = new CookieJar();
    const client = wrapper(
      axios.create({
        jar, // ✅ pasa el jar aquí
        withCredentials: true, // ✅ necesario para que axios use el jar
        timeout: Number(process.env.HTTP_TIMEOUT_MS ?? 20000),
        maxRedirects: 5,
        headers: {
          'User-Agent':
            process.env.HTTP_UA ??
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/119 Safari/537.36',
          'Accept-Language': 'es-CL,es;q=0.9,en;q=0.8',
          Accept:
            'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        },
      }),
    );
    return client;
  }
  /** 1) OCDS: trae documents.url desde tender/awards/contracts */
  async getOCDSDocURLs(codigo: string): Promise<string[]> {
    const url = `${this.base}/APISOCDS/OCDS/tender/${encodeURIComponent(codigo)}`;
    const { data } = await firstValueFrom(this.http.get<OCDSResponse>(url));
    const releases = data?.releases ?? [];
    const docs: OCDSDoc[] = [];

    for (const r of releases) {
      docs.push(...(r?.tender?.documents ?? []));
      (r?.awards ?? []).forEach((a) => docs.push(...(a?.documents ?? [])));
      (r?.contracts ?? []).forEach((c) => docs.push(...(c?.documents ?? [])));
    }
    const urls = docs.map((d) => d.url).filter(Boolean) as string[];
    return Array.from(new Set(urls));
  }

  /** Lee la ficha pública (DetailsAcquisition.aspx?qs=...) y extrae los links del popup de adjuntos. */
  async getAdjuntosLinksFromFicha(
    qs: string,
  ): Promise<Array<{ href: string; text: string }>> {
    const http = this.buildJarClient();

    // 1) Ficha (para setear cookies y capturar el link real)
    const detailsUrl = `${this.mpWebBase}/DetailsAcquisition.aspx?qs=${encodeURIComponent(qs)}`;
    const details = await http.get<string>(detailsUrl);
    const html = details.data;

    // 2) Captura el HREF completo de "Ver adjuntos"
    //    Preferimos href; si no, caemos a onclick.
    let hrefRaw: string | null = null;
    let encRaw: string | null = null;

    const mHref = html.match(
      /href="([^"]*Attachment\/ViewAttachment\.aspx\?enc=([^"#&]+))[^"]*"/i,
    );
    if (mHref) {
      hrefRaw = mHref[1]; // /Procurement/Modules/Attachment/ViewAttachment.aspx?enc=XXXXX+YYYY
      encRaw = mHref[2]; // XXXXX+YYYY  (¡con +!)
    } else {
      const mOn = html.match(
        /Attachment\/ViewAttachment\.aspx\?enc=([^'")\s]+)/i,
      );
      if (mOn) {
        encRaw = mOn[1]; // sólo el enc
        // ruta por defecto si sólo venía el enc en onclick:
        hrefRaw =
          '/Procurement/Modules/Attachment/ViewAttachment.aspx?enc=' + encRaw;
      }
    }

    if (!hrefRaw || !encRaw) {
      this.logger.warn('No se encontró el enlace de adjuntos en la ficha.');
      return [];
    }

    // 3) Absolutiza y re-encodea el enc (¡NO uses decodeURIComponent!)
    const u = new URL(hrefRaw, detailsUrl);
    u.searchParams.set('enc', encRaw); // esto hace + → %2B
    const attachUrl = u.toString();

    // 4) Pide la página de adjuntos con Referer
    const attach = await http.get<string>(attachUrl, {
      headers: { Referer: detailsUrl },
      // Para depurar redirecciones: pon temporalmente maxRedirects: 0
      // maxRedirects: 0,
      // validateStatus: s => s >= 200 && s < 400
    });

    const attachHtml = attach.data;

    // 5) Parsear anchors con archivos
    const $ = cheerio.load(attachHtml);
    const links: Array<{ href: string; text: string }> = [];

    $('a[href]').each((_, el) => {
      const raw = $(el).attr('href') ?? '';
      const text = ($(el).text() ?? '').trim();
      if (!raw) return;

      let abs: string;
      try {
        abs = raw.startsWith('http') ? raw : new URL(raw, attachUrl).toString();
      } catch {
        return;
      }

      if (
        /Attachment\//i.test(abs) ||
        /\.(pdf|docx?|xlsx?|pptx?|zip|rar)$/i.test(abs)
      ) {
        links.push({ href: abs, text });
      }
    });

    // Quitar duplicados
    const unique = Array.from(new Map(links.map((l) => [l.href, l])).values());
    return unique;
  }

  /** 2) API transaccional: agrega URLs conocidas como fallback. */
  async getTransactionalURLs(codigo: string): Promise<string[]> {
    const ticket = process.env.MP_TICKET;
    if (!ticket) return [];

    const url = `${this.base}/servicios/v1/publico/licitaciones.json?codigo=${encodeURIComponent(
      codigo,
    )}&ticket=${encodeURIComponent(ticket)}`;

    // Tratamos la forma del payload de manera defensiva (puede variar)
    const { data } = await firstValueFrom(
      this.http.get<{ Listado?: unknown }>(url),
    );

    // Listado puede venir como array, objeto o undefined
    const listadoArr = Array<any>(data?.Listado);
    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    const lic = listadoArr[0] ?? {};

    const urls: string[] = [];

    // Adjudicación (si existe y es del tipo esperado)
    if (
      lic &&
      typeof lic === 'object' &&
      'Adjudicacion' in lic &&
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      lic.Adjudicacion &&
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      typeof lic.Adjudicacion === 'object' &&
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      'UrlActa' in lic.Adjudicacion &&
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      typeof lic.Adjudicacion.UrlActa === 'string'
    ) {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-unsafe-member-access
      urls.push(lic.Adjudicacion.UrlActa);
    }

    // Items puede NO ser array; normalizamos siempre
    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
    const itemsArr = Array<any>(lic?.Items);
    for (const it of itemsArr) {
      if (it && typeof it === 'object' && 'UrlDocumento' in it) {
        const u = (it as { UrlDocumento?: unknown }).UrlDocumento;
        if (typeof u === 'string' && u.trim().length > 0) {
          urls.push(u);
        }
      }
    }

    return Array.from(new Set(urls));
  }

  private sanitizeName(s: string) {
    return s.replace(/[^\p{L}\p{N}.\-_\s]/gu, '_').slice(0, 120) || 'archivo';
  }

  private async ensureDir(dir: string) {
    await fs.promises.mkdir(dir, { recursive: true });
  }

  private filenameFromDisposition(header?: string): string | null {
    if (!header) return null;
    // filename*=UTF-8''<name> o filename="<name>"
    const mStar = header.match(/filename\*\s*=\s*(?:UTF-8'')?("?)([^";]+)\1/i);
    if (mStar?.[2]) return decodeURIComponent(mStar[2]);
    const m = header.match(/filename\s*=\s*"?([^";]+)"?/i);
    return m?.[1] ?? null;
  }

  private errMsg(err: unknown): string {
    if (err instanceof Error) return err.message;
    try {
      return JSON.stringify(err);
    } catch {
      return String(err);
    }
  }

  /** Descarga todos los adjuntos del popup de la ficha usando el mismo jar/cookies. */
  async downloadAdjuntosFromFicha(qs: string, outParentDir?: string) {
    const http = this.buildJarClient();
    const detailsUrl = `${this.mpWebBase}/DetailsAcquisition.aspx?qs=${encodeURIComponent(qs)}`;

    // Reutilizamos el parsing anterior pero con este cliente para mantener el jar
    const details = await http.get<string>(detailsUrl);
    const $ = cheerio.load(details.data);
    const onclick = $('#imgAdjuntos').attr('onclick') ?? '';
    const m = onclick.match(/Attachment\/ViewAttachment\.aspx\?enc=([^'"]+)/i);
    if (!m) {
      return {
        ok: false as const,
        count: 0,
        results: [],
        reason: 'No se encontró enlace de adjuntos en la ficha',
      };
    }
    const enc = decodeURIComponent(m[1]);
    const attachUrl = `${this.mpWebBase}/Attachment/ViewAttachment.aspx?enc=${enc}`;
    const attach = await http.get<string>(attachUrl, {
      headers: { Referer: detailsUrl },
    });

    const $$ = cheerio.load(attach.data);
    const anchors: Array<{ href: string; text: string }> = [];
    $$('a[href]').each((_, el) => {
      const raw = $$(el).attr('href') ?? '';
      const text = ($$(el).text() ?? '').trim();
      if (!raw) return;
      const abs = raw.startsWith('http')
        ? raw
        : new URL(raw, attachUrl).toString();
      if (
        /Attachment\//i.test(abs) ||
        /\.(pdf|docx?|xlsx?|pptx?|zip|rar)$/i.test(abs)
      ) {
        anchors.push({ href: abs, text });
      }
    });
    const links = Array.from(new Map(anchors.map((l) => [l.href, l])).values());

    // Carpeta de salida
    const baseDir = outParentDir ?? process.env.DOWNLOAD_DIR ?? './downloads';
    const folder = path.join(baseDir, this.sanitizeName(`ficha_${Date.now()}`));
    await fs.promises.mkdir(folder, { recursive: true });

    // Descarga con el mismo jar (no usar HttpService aquí)
    const limit = pLimit(4);
    const tasks = links.map(({ href, text }) =>
      limit(async () => {
        const resp = await http.get<NodeJS.ReadableStream>(href, {
          responseType: 'stream',
          headers: { Referer: attachUrl },
          maxRedirects: 5,
        });

        // Nombre por header o por ruta o por texto del link
        const disp = String(resp.headers['content-disposition'] ?? '');
        const mStar = disp.match(
          /filename\*\s*=\s*(?:UTF-8'')?("?)([^";]+)\1/i,
        );
        const mSimple = disp.match(/filename\s*=\s*"?([^";]+)"?/i);
        const fromHeader = mStar?.[2]
          ? decodeURIComponent(mStar[2])
          : (mSimple?.[1] ?? '');
        const fallback =
          path.basename(new URL(href).pathname) || text || 'archivo';
        const filename = this.sanitizeName(fromHeader || fallback);
        const outPath = path.join(folder, filename);

        await new Promise<void>((resolve, reject) => {
          const ws = fs.createWriteStream(outPath);
          resp.data.pipe(ws).on('finish', resolve).on('error', reject);
        });

        return { href, file: outPath, ok: true as const };
      }),
    );

    const settled = await Promise.allSettled(tasks);
    const downloaded = settled
      .filter((r) => r.status === 'fulfilled')
      .map(
        (r) =>
          (
            r as PromiseFulfilledResult<{
              href: string;
              file: string;
              ok: true;
            }>
          ).value,
      );
    const failed = settled
      .filter((r) => r.status === 'rejected')
      .map((r) => ({
        ok: false as const,
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access
        error: r.reason?.message ?? 'error',
        href: links[(settled as any[]).indexOf(r)].href,
      }));

    return {
      ok: true as const,
      count: downloaded.length,
      results: downloaded,
      failed,
      outputDir: folder,
    };
  }

  /** Descarga un archivo a disco */
  async downloadFile(fileUrl: string, folder: string): Promise<string> {
    await this.ensureDir(folder);

    let nameFromHeader: string | null = null;
    try {
      const head = await firstValueFrom(
        this.http.head<void>(fileUrl, { maxRedirects: 5 }),
      );
      // axios pone headers en minúscula
      const cd = (head.headers as Record<string, unknown>)[
        'content-disposition'
      ];
      nameFromHeader = this.filenameFromDisposition(
        typeof cd === 'string' ? cd : undefined,
      );
    } catch (e: unknown) {
      // ignora si falla HEAD (no romper)
      this.logger.debug(`HEAD falló (${fileUrl}): ${this.errMsg(e)}`);
    }

    // Nombre por header o por pathname
    const parsed = new URL(fileUrl);
    const fallback = path.basename(parsed.pathname) || 'archivo';
    const filename = this.sanitizeName(nameFromHeader ?? fallback);
    const outPath = path.join(folder, filename);

    // Tipar data como stream
    const resp = await firstValueFrom(
      this.http.request<NodeJS.ReadableStream>({
        method: 'GET',
        url: fileUrl,
        responseType: 'stream',
        maxRedirects: 5,
      }),
    );

    const stream = resp.data;
    await new Promise<void>((resolve, reject) => {
      const ws = fs.createWriteStream(outPath);
      stream.pipe(ws);
      ws.on('finish', resolve);
      ws.on('error', reject);
    });

    return outPath;
  }

  /** Orquestador: saca URLs (OCDS -> fallback transaccional) y descarga */
  async fetchAndDownloadAll(codigo: string, dryRun = false) {
    const baseDir = process.env.DOWNLOAD_DIR ?? './downloads';
    const folder = path.join(baseDir, this.sanitizeName(codigo));

    let urls = await this.getOCDSDocURLs(codigo);

    if (urls.length === 0) {
      const fromTxn = await this.getTransactionalURLs(codigo);
      urls = fromTxn;
    }

    urls = Array.from(new Set(urls)).filter(Boolean);

    if (dryRun) {
      return { codigo, found: urls.length, urls };
    }

    const limit = pLimit(4);
    const tasks = urls.map((u) =>
      limit(async (): Promise<DownloadOk | DownloadFail> => {
        try {
          const file = await this.downloadFile(u, folder);
          return { url: u, file, ok: true };
        } catch (err: unknown) {
          const msg = this.errMsg(err);
          this.logger.warn(`Falló descarga: ${u} -> ${msg}`);
          return { url: u, ok: false, error: msg };
        }
      }),
    );

    const results = await Promise.all(tasks);
    const downloaded = results.filter((r): r is DownloadOk => r.ok);
    const failed = results.filter((r): r is DownloadFail => !r.ok);

    return {
      codigo,
      totalURLs: urls.length,
      downloaded,
      failed,
      outputDir: folder,
    };
  }
}
