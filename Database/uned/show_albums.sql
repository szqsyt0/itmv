/*******************************************************************************
 * 显示专辑
 * 接收：页码，页大小
 * 返回：错误代码
 * 错误代码：0成功，1错误
 ******************************************************************************/
delimiter //
create procedure show_albums (
	in pagenum int,
	in pagesize int,
	out errno int
)
show_albums_main:begin
	declare position int;
	if (pagenum < 0 || pagesize < 0) then
		set errno = 1;
		leave show_albums_main;
	end if;
	set position=(pagenum - 1) * pagesize;
	select * from `album` limit position, pagesize;
	set errno = 0;
end//
delimiter ;

