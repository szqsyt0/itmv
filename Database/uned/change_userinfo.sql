delimiter //
/*******************************************************************************
 * 修改用户信息
 * 接收：用户id，新密码，新邮箱，新手机号，新身份
 * 返回：错误代码
 * 错误代码：0成功，1用户id不存在，2邮箱被占用，3手机号被占用，4密码格式错误
 ******************************************************************************/
create procedure `change_userinfo` (
	in id int unsigned,
	in password char(32),
	in email varchar(32),
	in phonenumber varchar(11),
	in identity varchar(6),
	out errno int
)
change_userinfo_main:begin
	declare eid int unsigned;
	declare u1 varchar(255);

	if (password is not null && password != '' && length(password) != 32) then 
		-- 密码格式错误且密码不为空
		set errno = 5;
		leave change_userinfo_main;
	end if;

	select `user_id` into eid from `user` where `user_id` = id;
	if (eid is null) then -- id不存在
		set errno = 1;
		leave change_userinfo_main;
	end if;

	if (useremail_existed(email)) then -- 新邮箱被占用
		set errno = 2;
		leave change_userinfo_main;
	end if;

	if (userphone_existed(phonenumber) ) then -- 手机号已存在
		set errno = 3;
		leave change_userinfo_main;
	end if;

	# 开始写入中间字符串u1
	# 先来email
	if (email is not null && email != '') then 
		set u1=concat_ws('','`user_email`=\'',email,'\'');
	end if;
	# 手机号
	if (phonenumber is not null && phonenumber!= '') then
		if (u1 is not null) then -- u1已有值，需要逗号
			set u1 = concat_ws('',u1,',');
		end if;
		set u1=concat_ws('',u1,'`user_phonenumber`=\'',phonenumber,'\'');
	end if;
	# 身份
	if (identity is not null && identity != '') then
		if (u1 is not null) then -- u1已有值，需要逗号
			set u1 = concat_ws('',u1,',');
		end if;
		set u1=concat_ws('',u1,'`user_identity`=\'',identity,'\'');
	end if;
	# 密码
	if (password is not null && password != '') then
		if (u1 is not null) then -- u1已有值，需要逗号
			set u1 = concat_ws('',u1,',');
		end if;
		set u1=concat_ws('',u1,'`user_password`=\'',password,'\'');
	end if;

	# 中间字符串处理完毕，整理sql,准备执行
	set @sql = concat_ws('','update `user` set ',u1,'where `user_id` = ',eid);
	prepare stmt from @sql;
	execute stmt;
	deallocate prepare stmt;

	set errno = 0;
end//
delimiter ;
