import { Logger, VersioningType } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { getConfig, IS_DEV } from './utils';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { knife4jSetup } from 'nestjs-knife4j';

export const config = getConfig();
const PORT = config.PORT || 8080;
const PREFIX = config.PREFIX || '/';
console.log(`Port: ${PORT}`, IS_DEV);

async function bootstrap() {
  const logger: Logger = new Logger('main.ts');
  const app = await NestFactory.create(AppModule, {
    // 开启日志级别打印
    logger: IS_DEV ? ['log', 'debug', 'error', 'warn'] : ['error', 'warn'],
  });
  //允许跨域请求
  app.enableCors();

  // 启动版本管理
  app.enableVersioning({
    defaultVersion: '1', // 不指定默认版本为v1
    type: VersioningType.URI,
  });

  // 给请求添加prefix
  app.setGlobalPrefix(PREFIX);

  //增加 swagger配置
  const options = new DocumentBuilder()
    .setTitle('Coffee example')
    .setDescription('The Coffee API description')
    .setVersion('1.0')
    .build();
  const document = SwaggerModule.createDocument(app, options);
  SwaggerModule.setup('api', app, document);
  //增加 knife4配置
  knife4jSetup(app, {
    urls: [
      {
        name: '2.X版本',
        url: `/api-json`,
        swaggerVersion: '3.0',
        location: `/api-json`,
      },
    ],
  });

  await app.listen(PORT, () => {
    logger.log(`服务已经启动,接口请访问:http://www.localhost:${PORT}/${PREFIX}`);
    logger.log(`swagger 请访问:http://www.localhost:${PORT}/doc.html`);
  });
}
bootstrap();
