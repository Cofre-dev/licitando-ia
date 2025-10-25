import {
  Controller,
  Get,
  Query,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { LicitacionesService } from './licitaciones.service';
import { isAxiosError } from 'axios';

// (ya debes tener mapAxiosError del mensaje anterior; si no, lo pego de nuevo)
function mapAxiosError(e: unknown, where: string): HttpException {
  if (isAxiosError(e)) {
    const status = e.response?.status;
    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access
    const code = (e as any)?.code;
    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    const body = e.response?.data;

    if (code === 'ECONNABORTED') {
      return new HttpException(
        { message: 'Timeout hacia ChileCompra', where, details: e.message },
        HttpStatus.GATEWAY_TIMEOUT,
      );
    }
    if (typeof status === 'number') {
      return new HttpException(
        {
          message: 'Error desde ChileCompra',
          where,
          upstreamStatus: status,
          // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
          upstreamData: body,
        },
        status,
      );
    }
    return new HttpException(
      {
        message: 'Fallo de red al llamar ChileCompra',
        where,
        details: e.message,
      },
      HttpStatus.BAD_GATEWAY,
    );
  }
  return new HttpException(
    { message: 'Error interno no controlado', where, details: String(e) },
    HttpStatus.INTERNAL_SERVER_ERROR,
  );
}

@Controller('licitaciones')
export class LicitacionesController {
  constructor(private readonly svc: LicitacionesService) {}

  // ... tus rutas previas ...

  /** Listar links de adjuntos desde la ficha pública (sin descargar) */
  @Get('ficha/adjuntos')
  async listarAdjuntos(@Query('qs') qs: string) {
    try {
      if (!qs) {
        throw new HttpException(
          { message: 'Falta el parámetro qs' },
          HttpStatus.BAD_REQUEST,
        );
      }
      const links = await this.svc.getAdjuntosLinksFromFicha(qs);
      return { qs, count: links.length, links };
    } catch (e) {
      throw mapAxiosError(e, 'GET /licitaciones/ficha/adjuntos');
    }
  }

  /** Descargar todos los adjuntos usando cookies de la ficha */
  @Get('ficha/adjuntos/descargar')
  async descargarAdjuntos(@Query('qs') qs: string) {
    try {
      if (!qs) {
        throw new HttpException(
          { message: 'Falta el parámetro qs' },
          HttpStatus.BAD_REQUEST,
        );
      }
      const res = await this.svc.downloadAdjuntosFromFicha(qs);
      return res;
    } catch (e) {
      throw mapAxiosError(e, 'GET /licitaciones/ficha/adjuntos/descargar');
    }
  }
}
