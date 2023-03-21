import { ApiProperty } from '@nestjs/swagger';
import { Transform, TransformFnParams } from 'class-transformer';
import {
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  BaseEntity,
  Column,
} from 'typeorm';

export class MyBaseEntity extends BaseEntity {
  @PrimaryGeneratedColumn({
    type: 'bigint',
    name: 'id',
    comment: '主键id',
  })
  id!: number;

  @ApiProperty({
    type: String,
    description: '创建时间',
  })
  @Transform((row: TransformFnParams) => +new Date(row.value))
  @CreateDateColumn({
    type: 'timestamp',
    nullable: false,
    name: 'created_time',
    comment: '创建时间',
  })
  createdTime!: Date;

  @ApiProperty({
    type: String,
    description: '更新时间',
  })
  @Transform((row: TransformFnParams) => +new Date(row.value))
  @UpdateDateColumn({
    type: 'timestamp',
    nullable: false,
    name: 'updated_time',
    comment: '更新时间',
  })
  updatedTime!: Date;

  @ApiProperty({
    type: String,
    description: '逻辑删除标记：0正常，1删除',
  })
  @Column({ name: 'is_deteled', comment: '逻辑删除标记：0正常，1删除' })
  isDeleted?: number;

  @ApiProperty({
    type: String,
    description: '创建人',
  })
  @Column({ name: 'created_by', comment: '创建人' })
  createdBy?: number;

  @ApiProperty({
    type: String,
    description: '更新人',
  })
  @Column({ name: 'updated_by', comment: '更新人' })
  updatedBy?: number;
}
