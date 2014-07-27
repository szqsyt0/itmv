/*******************************************************************************
 * 删除用户
 * 输入：用户id
 * 输出：错误代码，0成功，1id不存在
 ******************************************************************************/
delimiter //
create procedure `delete_user` (
	in id int unsigned,
	out errno int
)
delete_user_main:begin
	declare eid int unsigned;
	select `user_id` into eid from `user` where `user_id`=id;
	if (eid is null) then 
		set errno = 1;
		leave delete_user_main;
	end if;
	delete from `user` where `user_id` = eid;
	set errno = 0;
end//
delimiter ;

