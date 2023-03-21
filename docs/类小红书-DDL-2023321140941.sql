drop table if exists users;
create table users(
    `id` bigint(20) not null auto_increment  comment '用户id-主键' ,
    `user_name` varchar(50) not null   comment '用户名' ,
    `salt` varchar(20) not null   comment '盐' ,
    `email` varchar(50)    comment 'email' ,
    `mobile` varchar(50)    comment '手机号' ,
    `avatar` text    comment '头像' ,
    `region` varchar(100)    comment '所在地区' ,
    `language` varchar(100)   default 'english' comment '语言' ,
    `gender` int(2)    comment '性别：1男，2女，3其他' ,
    `birthday` datetime    comment '出生日期' ,
    `last_login_time` datetime    comment '最后登录时间' ,
    `last_login_ip` varchar(50)    comment '最后登录ip' ,
    `status` int(2) not null  default 1 comment '用户状态：0禁用，1正常' ,
    `is_deleted` int(2) not null  default 0 comment '逻辑删除标记：0正常，1删除' ,
    `created_by` bigint(20)    comment '创建人' ,
    `created_time` datetime    comment '创建时间' ,
    `updated_by` bigint(20)    comment '更新人' ,
    `updated_time` datetime    comment '更新时间' ,
    primary key (id)
)  comment = '用户表';


create index indx_users_region on users(region);

drop table if exists user_auths;
create table user_auths(
    `id` bigint(20) not null auto_increment  comment '主键id' ,
    `user_id` bigint(20) not null   comment '用户id' ,
    `identity_type` varchar(50) not null  default 'pwd' comment '登录类别;pwd:密码登录,fb:facebook,gg:google，ins:instagram' ,
    `identifier` varchar(255)    comment '身份唯一标识;user_id,fb id,google id,ins id' ,
    `credential` varchar(255)    comment '站内账号是密码、第三方登录是token' ,
    `ifverified` int(2)   default 0 comment '授权账号是否被验证;0未验证，1已验证' ,
    `expires` datetime    comment '超时时间' ,
    `is_deteled` int(2)   default 0 comment '逻辑删除标记：0正常，1删除' ,
    `created_by` bigint(20)    comment '创建人' ,
    `created_time` datetime    comment '创建时间' ,
    `updated_by` bigint(20)    comment '更新人' ,
    `updated_time` datetime    comment '更新时间' ,
    primary key (id)
)  comment = '用户授权表-联合登录';


create index indx_user_id on user_auths(user_id);

drop table if exists posts;
create table posts(
    `id` bigint(20) not null auto_increment  comment 'post_id文章id' ,
    `push_date` datetime not null   comment '发布日期' ,
    `push_user_id` bigint(20) not null   comment '发布人' ,
    `title` varchar(300) not null   comment '标题' ,
    `content` text not null   comment '博文内容' ,
    `like_count` int(10)    comment '点赞数' ,
    `comment_count` int(10)    comment '评论数' ,
    `read_count` int(10)    comment '阅读数' ,
    `is_top` int(2)   default 0 comment '是否置顶:0否，1是' ,
    `summary` text    comment '文章摘要' ,
    `post_status` int(2)   default 0 comment '文章状态：0草稿，1申请发布，2发布，3废弃' ,
    `is_deteled` int(2)   default 0 comment '逻辑删除标记：0正常，1删除' ,
    `created_by` bigint(20)    comment '创建人' ,
    `created_time` datetime    comment '创建时间' ,
    `updated_by` bigint(20)    comment '更新人' ,
    `updated_time` datetime    comment '更新时间' ,
    primary key (id)
)  comment = '文章表';

drop table if exists post_tag;
create table post_tag(
    `id` bigint(20) not null auto_increment  comment '主键id' ,
    `post_id` bigint(20)    comment '文章id' ,
    `tag_id` bigint(20)    comment '标签id' ,
    `is_deteled` int(2)   default 0 comment '逻辑删除标记：0正常，1删除' ,
    `created_by` bigint(20)    comment '创建人' ,
    `created_time` datetime    comment '创建时间' ,
    `updated_by` bigint(20)    comment '更新人' ,
    `updated_time` datetime    comment '更新时间' ,
    primary key (id)
)  comment = '文章标签表';

drop table if exists tag;
create table tag(
    `id` bigint(20) not null auto_increment  comment '标签id' ,
    `tag_name` varchar(100)    comment '标签名称' ,
    `alias_name` varchar(100)    comment '标签别名' ,
    `description` varchar(100)    comment '标签描述' ,
    `is_deteled` int(2)   default 0 comment '逻辑删除标记：0正常，1删除' ,
    `created_by` bigint(20)    comment '创建人' ,
    `created_time` datetime    comment '创建时间' ,
    `updated_by` bigint(20)    comment '更新人' ,
    `updated_time` datetime    comment '更新时间' ,
    primary key (id)
)  comment = '文章标签定义表';

drop table if exists post_discuss;
create table post_discuss(
    `id` bigint(20) not null auto_increment  comment '评论id' ,
    `discuss_time` datetime    comment '评论时间' ,
    `like_count` int(11)    comment '点赞数量' ,
    `discuss_user` bigint(20)    comment '评论人id' ,
    `content` text    comment '评论内容' ,
    `post_id` bigint(20)    comment '评论文章id' ,
    `parent_id` varchar(255)    comment '父评论id' ,
    `is_deteled` int(2)   default 0 comment '逻辑删除标记：0正常，1删除' ,
    `created_by` bigint(20)    comment '创建人' ,
    `created_time` datetime    comment '创建时间' ,
    `updated_by` bigint(20)    comment '更新人' ,
    `updated_time` datetime    comment '更新时间' ,
    primary key (id)
)  comment = '评论表';

drop table if exists post_operate;
create table post_operate(
    `id` bigint(20) not null auto_increment  comment '主键id' ,
    `operate_type` int(2)    comment '操作类型：1点赞/2收藏/3转发/4举报' ,
    `operate_id` bigint(20)    comment '操作人id' ,
    `post_id` bigint(20)    comment '文章id' ,
    `is_deteled` int(2)   default 0 comment '逻辑删除标记：0正常，1删除' ,
    `created_by` bigint(20)    comment '创建人' ,
    `created_time` datetime    comment '创建时间' ,
    `updated_by` bigint(20)    comment '更新人' ,
    `updated_time` datetime    comment '更新时间' ,
    primary key (id)
)  comment = '文章操作表';

drop table if exists user_follow;
create table user_follow(
    `id` bigint(20) not null auto_increment  comment '主键id' ,
    `user_id` bigint(20) not null   comment '被关注用户id' ,
    `follow_id` bigint(20) not null   comment '关注用户id' ,
    `is_deteled` int(2)   default 0 comment '逻辑删除标记：0正常，1删除' ,
    `created_by` bigint(20)    comment '创建人' ,
    `created_time` datetime    comment '创建时间' ,
    `updated_by` bigint(20)    comment '更新人' ,
    `updated_time` datetime    comment '更新时间' ,
    primary key (id)
)  comment = '用户关注表';

drop table if exists post_imgs;
create table post_imgs(
    `id` bigint(20) not null auto_increment  comment '主键id' ,
    `post_id` bigint(20) not null   comment '文章id' ,
    `img_id` varchar(255)    comment '图片id' ,
    `img_url` varchar(255)    comment '图片url' ,
    `is_deteled` int(2)   default 0 comment '逻辑删除标记：0正常，1删除' ,
    `created_by` bigint(20)    comment '创建人' ,
    `created_time` datetime    comment '创建时间' ,
    `updated_by` bigint(20)    comment '更新人' ,
    `updated_time` datetime    comment '更新时间' ,
    primary key (id)
)  comment = '文章图片表';

drop table if exists messages;
create table messages(
    `id` bigint(20) not null auto_increment  comment '主键id' ,
    `user_id` bigint(20) not null   comment '接收用户id' ,
    `msg_type` int(2) not null   comment '消息类型' ,
    `msg_content` varchar(255) not null   comment '消息内容' ,
    `is_sended` int(2)   default 0 comment '是否已发送，0未发送，1已发送，2发送错误' ,
    `error_msg` varchar(255)    comment '发送错误信息' ,
    `send_flag` int(2)   default 1 comment '发送标记，1立即发送，2延迟发送' ,
    `delay_time` datetime    comment '延迟发送时间' ,
    `is_deteled` int(2)   default 0 comment '逻辑删除标记：0正常，1删除' ,
    `created_by` bigint(20)    comment '创建人' ,
    `created_time` datetime    comment '创建时间' ,
    `updated_by` bigint(20)    comment '更新人' ,
    `updated_time` datetime    comment '更新时间' ,
    primary key (id)
)  comment = '消息管理表';

