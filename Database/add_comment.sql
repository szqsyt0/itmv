/*******************************************************************************
 * 添加一条评论
 * 输入：评论者名字，评论的视频，父评论的id，评论内容
 * 输出：错误代码
 * 错误代码：0成功，1错误
 *******************************************************************************/
delimiter //
create procedure `add_comment` (
	in commenter varchar(32),
	in video int unsigned,
	in parent int unsigned,
	in content text,
	out errno int
)
add_comment_main:begin


INSERT INTO `microclass`.`comment`
(`parent_id`,
`video_id`,
`commentator_id`,
`comment_text`,
`comment_time`)
VALUES
(<{parent_id: }>,
<{video_id: }>,
<{commentator_id: }>,
<{comment_text: }>,
<{comment_time: }>);

end//
delimiter ;;
