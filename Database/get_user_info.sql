/*******************************************************************************
 * 返回用户详细信息
 * 输入：用户id
 * 输出：错误代码 0成功，1id不存在
 * 修改时间：2014年7月14日 星期一 23:42:11
 ******************************************************************************/
delimiter //
create procedure get_user_info (
	in id int unsigned,
	out errno int
)
get_user_info_main:begin
	declare eid int unsigned;

	select `user_id` into eid from `user` where `user_id` = id;
	if (eid is null) then
		set errno = 1;
		leave get_user_info_main;
	end if;
	select * from (
		select `user_id` as `id`,`user_name`,`user_email`
			,`user_lastlogin`,`user_status` 
			from `user` where `user_id` = id
	) s1 left join (
		select * from `user_extra` where `user_id` = id
	) s2 on s1.`id`=s2.`user_id`;
	set errno = 0;
end//
delimiter ;
