import { QueryOptionsDto } from '@src/common/shared/dto/query.options.dto';

export class QueryAccountDto extends QueryOptionsDto {
  readonly username!: string;
  readonly status!: string;
  readonly mobile!: string;
  readonly email!: string;
}
