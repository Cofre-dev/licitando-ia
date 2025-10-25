import { Module } from '@nestjs/common';
import { LicitacionesModule } from './licitaciones/licitaciones.module';

@Module({
  imports: [LicitacionesModule],
})
export class AppModule {}
