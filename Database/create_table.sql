# 创建专用用户
create user 'itmvuser'@'localhost' identified by 'texk$u123';
# 创建数据库itmv
create database itmv character set utf8;
# 只给用户执行的权力
grant execute on itmv.* to itmvuser@localhost;

# 创建表开始
use itmv;
-- 用户表
create table `user` (
	`user_id` int unsigned not null primary key auto_increment comment '自动增长的用户id',
	`user_name` varchar(32) not null unique comment '唯一的，可用于登录的用户名',  
	`user_password` char(128) not null comment '密码，使用sha512散列存储',
	`user_email` varchar(32) not null unique comment '邮箱，必须有的',
	`user_identity` char(6) not null default 'user' comment '身份，若为admin则是管理员,sadmin为超级管理员',
	`user_lastlogin` date not null comment '最后登录的日期',
	`user_status` tinyint default 0 not null comment '用户状态，0为正常，1为被禁止评论'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- 用户额外信息
create table `user_extra` (
	`user_id` int unsigned not null primary key comment '依赖user表中的id',
	constraint `user_extra_id_must_exist` foreign key (`user_id`) references `user` (`user_id`),
	`user_shownname` varchar(64) comment '显示名(昵称)，可以为空',
	`user_sex` char not null default 0 comment '性别，0男1女2其他',
	`user_phonenumber` char(11) unique comment '手机号，可以为空，可用来找回密码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- 添加默认管理员账户
insert into `user` 
( `user_id`, `user_name`, `user_password`, `user_email`,
       	`user_identity`, `user_lastlogin`, `user_status`)
values ( default, 'admin', sha2('admin',512), 'admin@admin.com',
	'sadmin', curdate(), default);

-- 分类表
create table `category` (
	`category_id` int unsigned not null primary key auto_increment comment 
'分类的id',
	`parent_id` int unsigned not null default 0 comment '父类别id',
	`category_name` varchar(32) not null unique comment '该分类的名字,,不可重复'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- 视频表
create table `video` (
	`video_id` int unsigned not null primary key auto_increment comment '自动增长的视频id',
	`video_title` varchar(128) not null comment '视频标题',
	`video_path` varchar(32) not null comment '视频的相对存储路径',
	`video_poster` varchar(32) default '0' comment '视频封面，使用路径存储',
	`video_playcount` int unsigned not null default 0 comment '播放次数统计',
	`video_rating` tinyint not null default 0 comment '平均评分',
	`video_rating_count` int unsigned not null default 0 comment '评分次数',
	`video_intro` text comment '视频简介',
	`video_category_id` int unsigned not null comment '分类的id',
	`video_uploader_id` int unsigned not null comment '上传者id',
	`video_duration` float unsigned not null default 0 comment '视频持续时间，以秒为单位',
	-- 外键约束，上传者id必须存在
	constraint `fk_video_uploader_id` foreign key (`video_uploader_id`) references `user` (`user_id`),
	-- 外键约束，分类id必须存在
	constraint `fk_video_category_id` foreign key (`video_category_id`) references `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- 评论表
create table `comment` (
	`comment_id` int unsigned not null primary key auto_increment comment '评论的id',
	`parent_id` int unsigned comment '父评论的id，即评论中的评论需要此项',
	`video_id` int unsigned not null comment '所评论的视频id',
	`commentator_id` int unsigned not null comment '评论者的id',
	`comment_text` text not null comment '评论内容，不准为空',
	`comment_time` datetime not null comment '评论发表时间',
	-- 若评论的视频被删除，所属的评论也全部删除
	constraint `fk_comment_video_id` foreign key (`video_id`) references `video` (`video_id`) on delete cascade on update cascade,
-- 若评论者的信息被删除，所属评论全部删除
	constraint `fk_comment_commentator_id` foreign key (`commentator_id`) references `user` (`user_id`) on delete cascade on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- 收藏的视频表
create table `favorite_video` (
	`user_id` int unsigned not null comment '收藏者id',
	`video_id` int unsigned not null comment '收藏的视频id',
	`favorite_time` date not null comment '收藏时间',
	constraint `fk_favorite_video_user_id` foreign key (`user_id`) references `user` (`user_id`) on delete cascade on update cascade,
	constraint `fk_favorite_video_video_id` foreign key (`video_id`) references `video` (`video_id`) on delete cascade on update cascade,
	constraint `pk_favorite_video` primary key (user_id, video_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- 观看记录
create table `watch_record` (
	`user_id` int unsigned not null comment '用户id',
	`video_id` int unsigned not null comment '视频id',
	`last_time` datetime not null comment '最后观看时间，包括时分秒',
	`watch_point` int unsigned not null default 0 comment '观看的时间点，单位秒，即“您看到了xx:xx”',
	-- 视频被删除则观看记录也删除
	constraint ` fk_record_video_idt` foreign key (`video_id`) references `video` (`video_id`) on delete cascade on update cascade,
	-- 用户消失则观看记录消失
	constraint `fk_record_user_id` foreign key (`user_id`) references `user` (`user_id`) on delete cascade on update cascade,
	constraint `pk_watch_record` primary key (`user_id`, `video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- 标签
create table `tag` (
	`tag_id` int primary key auto_increment comment '标签id',
	`tag_name` varchar(32) not null comment '标签名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- 视频标签
create table `video_tags` (
	`tag_id` int unsigned not null,
	`video_id` int unsigned not null,
	constraint `pk_video_tags` primary key (`tag_id`,`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

#################################创建表结束#####################################
 
