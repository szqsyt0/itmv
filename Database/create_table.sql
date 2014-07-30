# 创建专用用户
create user 'itmvuser'@'%' identified by 'texk$u123';
# 创建数据库itmv
create database itmv character set utf8;
# 给用户对该数据库的所有权力
grant all privileges on itmv.* to itmvuser;

# 创建表开始
use itmv;
-- 用户表
create table `user` (
	`id` int unsigned not null primary key auto_increment comment '自动增长的用户id',
	`name` varchar(32) not null unique comment '唯一的，可用于登录的用户名',
	`password` varchar(128) not null comment '密码，使用sha512散列存储',
	`email` varchar(64) not null unique comment '邮箱，必须有的',
	`identity` tinyint not null default 0 comment '身份，0用户1管理员2超级管理员',
	`lastlogin` date not null comment '最后登录的日期',
	`status` tinyint default 0 not null comment '用户状态，0为正常，1为被禁止评论。-1禁止登录'
) comment '用户主表，每次登录都必要的信息存在这里。';

-- 用户额外信息
create table `user_extra` (
	`user_id` int unsigned not null primary key comment '依赖user表中的id',
	constraint `user_extra_id_must_exist` foreign key (`user_id`) references `user` (`id`),
	`nickname` varchar(64) comment '昵称(显示名)，可以为空',
	`sex` tinyint unsigned not null default 0 comment '性别，0保密1男2女',
	`mobile` char(11) unique comment '手机号，可以为空，可用来找回密码'
) comment '用户信息表，需要查看详细信息时才会用到';

-- 添加默认管理员账户
insert into `user`
( `id`, `name`, `password`, `email`,
       	`identity`, `lastlogin`, `status`)
values ( 1, 'admin', sha2('admin',512), 'admin@admin.com',
	2, curdate(), default);

-- 分类表
create table `category` (
	`id` int unsigned not null primary key auto_increment comment
'分类的id',
	`parent_id` int unsigned not null default 0 comment '父类别id',
	`name` varchar(32) not null unique comment '该分类的名字,不可重复'
) comment '分类表，视频的分类';

-- 视频表
create table `video` (
	`id` int unsigned not null primary key auto_increment comment '自动增长的视频id',
	`title` varchar(128) not null comment '视频标题',
	`path` varchar(128) not null comment '视频的相对存储路径',
	`poster` varchar(128) default '0' comment '视频封面，使用路径存储',
	`playcount` int unsigned not null default 0 comment '播放次数统计',
	`rating` tinyint not null default 0 comment '平均评分',
	`rating_sum` int unsigned not null default 0 comment '评分次数',
	`intro` text comment '视频简介',
	`category_id` int unsigned not null comment '分类的id',
	`uploader_id` int unsigned not null comment '上传者id',
	`share_sum` int unsigned not null default 0 comment '视频被分享的次数',
	`up` int unsigned not null default 0 comment '“顶”的数目',
	`down` int unsigned not null default 0 comment '“踩”的数目',
	-- 外键约束，上传者id必须存在
	-- #constraint `fk_video_uploader_id` foreign key (`uploader_id`) references `user` (`id`),
	-- 外键约束，分类id必须存在
	-- #constraint `fk_video_category_id` foreign key (`category_id`) references `category` (`id`),
	`duration` float unsigned not null default 0 comment '视频持续时间，以秒为单位'
) comment '视频表，视频的所有属性全部包括';

-- 评论表
create table `comment` (
	`id` int unsigned not null primary key auto_increment comment '评论的id',
	`parent_id` int unsigned comment '父评论的id，即评论中的评论需要此项',
	`video_id` int unsigned not null comment '所评论的视频id',
	`user_id` int unsigned not null comment '评论者的id',
	-- 若评论的视频被删除，所属的评论也全部删除
	-- #constraint `fk_comment_video_id` foreign key (`video_id`) references `video` (`id`) on delete cascade on update cascade,
	-- 若评论者的信息被删除，所属评论全部删除
	-- #constraint `fk_comment_commentator_id` foreign key (`user_id`) references `user` (`id`) on delete cascade on update cascade,
	`content` text not null comment '评论内容，不准为空',
	`time` datetime not null comment '评论发表时间'
) comment '评论表，视频评论';

-- 收藏的视频表
create table `favorite_video` (
	`user_id` int unsigned not null comment '收藏者id',
	`video_id` int unsigned not null comment '收藏的视频id',
	`time` date not null comment '收藏时间',
	-- #constraint `fk_favorite_video_user_id` foreign key (`user_id`) references `user` (`id`) on delete cascade on update cascade,
	-- #constraint `fk_favorite_video_video_id` foreign key (`video_id`) references `video` (`id`) on delete cascade on update cascade,
	constraint `pk_favorite_video` primary key (user_id, video_id)
) comment '收藏表，用户收藏视频的信息';

-- 观看记录
create table `watch_record` (
	`user_id` int unsigned not null comment '用户id',
	`video_id` int unsigned not null comment '视频id',
	`last_time` datetime not null comment '最后观看时间，包括时分秒',
	`watch_point` int unsigned not null default 0 comment '观看的时间点，单位秒，即“您看到了xx:xx”',
	-- 视频被删除则观看记录也删除
	-- #constraint `fk_record_video_id` foreign key (`video_id`) references `video` (`id`) on delete cascade on update cascade,
	-- 用户消失则观看记录消失
	-- #constraint `fk_record_user_id` foreign key (`user_id`) references `user` (`id`) on delete cascade on update cascade,
	constraint `pk_watch_record` primary key (`user_id`, `video_id`)
) comment '观看记录表';

-- 标签
create table `tag` (
	`id` int primary key auto_increment comment '标签id',
	`name` varchar(32) not null comment '标签名'
) comment '标签，视频和问答都能用';

-- 视频标签
create table `video_tags` (
	`tag_id` int unsigned not null,
	`video_id` int unsigned not null,
	-- #constraint `fk_video_tags_tag_id` foreign key (`tag_id`) references `tag` (`id`) on delete cascade on update cascade,
	-- #constraint `fk_video_tags_video_id` foreign key (`video_id`) references `video` (`id`) on delete cascade on update cascade,
	constraint `pk_video_tags` primary key (`tag_id`,`video_id`)
) comment '视频标签表，存储视频贴的标签信息';

-- 笔记表
create table `note` (
	`id` int unsigned not null primary key,
	`user_id` int unsigned not null comment '用户id',
	-- #constraint `fk_note_user_id` foreign key (`user_id`) references `user` (`id`),
	`video_id` int unsigned not null comment '视频id',
	-- #constraint `fk_note_video_id` foreign key (`video_id`) references `video` (`id`),
	`time` datetime not null comment '笔记记录时间',
	`last_change` datetime not null comment '最后修改时间',
	`status` tinyint not null default 0 comment '笔记状态，0正常-1回收站',
	`privilege` tinyint not null default 0 comment '权限，0私有1公开',
	`rating` tinyint not null default 0 comment '笔记评分',
	`rating_sum` int unsigned not null default 0 comment '评分人数'
) comment '笔记表';

-- 提问表
create table `question` (
	`id` int unsigned not null primary key,
	`title` varchar(128) not null comment '问答标题',
	`content` text not null comment '提问的内容',
	`user_id` int unsigned not null comment '提问人id',
	-- #constraint `fk_question_user_id` foreign key (`user_id`) references `user` (`id`),
	`time` datetime not null comment '提问创建时间',
	`last_change` datetime not null comment '最后修改时间',
	`answer_sum` int unsigned not null comment '回答总数，需要后台程序保持正确性'
) comment '提问表，问答中的提问';

-- 回答表
create table `answer` (
	`id` int unsigned not null primary key,
	`content` text not null comment '回答内容',
	`user_id` int unsigned not null comment '回答着id',
	-- #constraint `fk_answer_user_id` foreign key (`user_id`) references `user` (`id`),
	`time` datetime not null comment '回答时间',
	`last_change` datetime not null comment '最后修改时间',
	`up` int unsigned not null default 0 comment '“顶”的数目',
	`down` int unsigned not null default 0 comment '“踩”的数目'
) comment '回答表，对问答中提问的回答';

-- 回答的回复表
create table `answer_reply` (
	`id` int unsigned not null primary key,
	`answer_id` int unsigned not null comment '所回复的回答的id',
	`user_id` int unsigned not null comment '回复者id',
	`content` text not null comment '回复的内容',
	`time` datetime not null comment '回复时间'
) comment '回答的回复表，对提问的回答的回复';

-- 问答标签表
create table `question_tags` (
	`tag_id` int unsigned not null,
	`question_id` int unsigned not null,
	-- #constraint `fk_question_tags_tag_id` foreign key (`tag_id`) references `tag` (`id`) on delete cascade on update cascade,
	-- #constraint `fk_video_tags_question_id` foreign key (`question_id`) references `question` (`id`) on delete cascade on update cascade,
	constraint `pk_question_tags` primary key (`tag_id`,`question_id`)
) comment '问题标签';

#################################创建表结束#####################################

