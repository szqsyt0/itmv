delimiter //
/*******************************************************************************
 * 添加分类
 * 接收：分类名，所属父分类名
 * 返回：错误代码
 * 错误代码：0成功，1分类名已存在，2父分类id不存在
 ******************************************************************************/
create procedure add_category (
	in name varchar(32),
	in parentid int unsigned,
	out errno int
)
add_category_main:begin
	declare parent_id int unsigned;
	if (category_existed (name)) then
		set errno = 1;
		leave add_category_main;
	end if;
	
	select `category_id` into parent_id 
		from `category` where `category_id` = parentid;
	if (parentid is not null and parent_id is null) then
		set errno = 2;
		leave add_category_main;
	end if;

	if (parent_id is null) then 
		set parent_id=0;
	end if;
	insert into `category` values
		(default,parent_id,name);
	set errno = 0;
end//##########################添加分类结束#####################################

-- 判断分类名是否存在
create function category_existed (categoryname varchar(32))
	returns boolean
	DETERMINISTIC
begin
	declare counter int;
	select count(`category_id`) into counter from `category` where 
`category_name`=categoryname;
	if (counter > 0) then
		return true;
	else
		return false;
	end if;
	return true;
end//
delimiter ;
############################################################################ 
