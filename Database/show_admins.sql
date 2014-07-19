/*******************************************************************************
 * 返回所有管理员的信息，超级管理员可以执行
 * 接收：页码，页大小
 * 返回：错误代码
 * 错误代码：0正确，1失败
 ******************************************************************************/
delimiter //
create procedure show_admins (
	in pagenum int,
	in pagesize int,
	out errno int
)
show_admins_main:begin
	declare position int;

	if (pagenum < 0 || pagesize <= 0) then
		set errno = 1;
		leave show_admins_main;
	end if;
	set position=(pagenum - 1) * pagesize;
	select * from `user` where `user_identity`='admin' or `user_identity`='sadmin'
       	limit position, pagesize;
	set errno=0;
end//
delimiter ;

