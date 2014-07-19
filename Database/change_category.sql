/*******************************************************************************
 * 修改分类信息
 * 输入：分类id，新分类名，新父分类id
 * 输出：错误代码
 * 错误代码：0成功，1分类名不存在，2父分类id不存在
 ******************************************************************************/
delimiter //
create procedure change_category (
	in id int unsigned,
	in newname varchar(32),
	in parentid int unsigned,
	out errno int
)
change_category_main:begin
	declare eid int unsigned;
	declare pid int unsigned;

	# 分类id不存在
	select `category_id` into eid from `category` where `category_id`=id;
	if (eid is null) then
		set errno = 1;
		leave change_category_main;
	end if;

	# 父分类传来null
	if (parentid is null) then
		set pid = 0;
	else # 判断父分类不为空 || 父分类id不存在
		select `category_id` into pid from `category` where `category_id`=parentid;
		if (pid is null) then
			set errno = 2;
			leave change_category_main;
		end if;
	end if;

	# 进行修改
	update `category`
		set `category_name` = newname, `parent_id` = pid 
		where `category_id` = id;

	set errno = 0;
end//
delimiter ;

