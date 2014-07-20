/*******************************************************************************
 * 返回评论列表
 * 输入：页码，分页大小
 * 输出：错误代码
 * 错误代码：0成功，1错误
 *******************************************************************************/
delimiter //
create procedure `show_comments` (
	in pagenum int,
	in pagesize int,
	out errno int
)
show_comments_main:begin
	declare position int;
	if (pagenum < 0 || pagesize < 0) then 
		set errno = 1;
		leave show_comments_main;
	end if;
	set position=(pagenum - 1) * pagesize;
	select * from `comment` limit position, pagesize;
	set errno = 0;
end//
delimiter ;
