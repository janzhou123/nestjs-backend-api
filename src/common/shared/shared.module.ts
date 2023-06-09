import { Global, Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AccountEntity } from '@src/modules/account/entities/account.entity';
// import { InitDbService } from './services/init-db.service';

@Global()
@Module({
  imports: [ConfigModule, TypeOrmModule.forFeature([AccountEntity])],
  providers: [],
})
export class SharedModule {}
