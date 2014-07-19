/*******************************************************************************
 * 删除评论及其所有子评论
 * 输入：评论id
 * 输出：错误代码
 * 错误代码：0成功，1错误
 *******************************************************************************/
delimiter //
create procedure delete_comment (
	in id int unsigned,
	out errno int
)
delete_comment_main:begin
	declare eid int unsigned;

	select `id` into eid from `comment` where `comment_id`=id;
	if (eid is null) then
		set errno = 1;
		leave delete_comment_main;
	end if;
	delete from `comment` where `parent_id` = id;
	delete from `comment` where `comment_id` = id;
	set errno = 0;
end//
delimiter ;

