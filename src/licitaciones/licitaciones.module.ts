// src/licitaciones/licitaciones.module.ts
import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { ConfigModule } from '@nestjs/config';
import { LicitacionesService } from './licitaciones.service';
import { LicitacionesController } from './licitaciones.controller';

@Module({
  imports: [
    // eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
    ConfigModule.forRoot({ isGlobal: true }),
    HttpModule.register({
      timeout: Number(process.env.HTTP_TIMEOUT_MS ?? 20000),
      maxRedirects: 5,
    }),
  ],
  controllers: [LicitacionesController],
  providers: [LicitacionesService],
})
export class LicitacionesModule {}
