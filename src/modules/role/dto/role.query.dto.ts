import { QueryOptionsDto } from '@src/common/shared/dto/query.options.dto';

export class QueryRoleDto extends QueryOptionsDto {
  readonly name!: string; // 角色名称
}
