存储过程的参数说明
==================================================
# 用户相关
===============
## 登录
login(username,password,@id,@identity,@err)
  登录验证的存储过程。
  修改时间：2014年7月14日 星期一 23:00:29
### 参数列表

#### 输入
1. 用户名 varchar(32) 可以为邮箱或用户名
2. 密码 char(128) md5加密过的32位密码

#### 输出
4. id unsignded int 型的用户id号
5. 身份 char(6) 管理员为sadmin或admin，用户为user
6. 错误代码 0登录成功，1密码错误，2无该用户

===============
## 注册
register(name,password,email,identity,@err)
  注册新用户，可以注册为管理员
  修改时间：2014年7月14日 星期一 23:25:56
### 参数列表

#### 输入
1. 用户名 varchar(32) 唯一的用户名
2. 密码 char(128) md5加密的32位密码
3. 邮箱 varchar(32) 唯一的邮箱
4. 身份 char(6) 可以为'admin' 'sadmin' 'user'，默认为'user'

#### 输出
5. 错误代码 int 0注册成功，1用户名存在，2邮箱存在，3手机号存在

===============
## 改密码
change_password(userid,oldpassword,newpassword,@err)
  修改时间：2014年7月14日 星期一 23:31:56
### 参数列表

#### 输入
1. 用户id int unsigned 用户id
2. 原密码 char(128) sha512加密的128位密码
3. 新密码 char(128) 128位sha512

#### 输出
4. 错误代码 0成功，1原密码错误，2用户id不存在，3新密码格式错误

===============
## 获取用户信息
get_user_info(id,@err)
  获取某用户的所有信息
  修改时间：2014年7月14日 星期一 23:42:11
### 参数列表

#### 输入
1. id int unsigned

#### 输出
2. 错误代码 0成功, 1id不存在

===============
## 返回所有管理员
show_admins

### 参数列表

#### 输入
1. 页码 int 第几页
2. 页大小 int 一页显示多少条

#### 输出
3. 错误代码 0成功, 1失败(页码和页大小不对)

===============
## 修改用户信息
change_userinfo
  修改基本用户信息，不需要修改的信息需要用null代替
  修改时间：

### 参数列表

#### 输入
1. 用户id int 要修改的用户id
2. 新密码 char(32) 可为null
3. 新邮箱 varchar(32) 可为null，不可重复
4. 新手机 varchar(11) 可为null，不可重复
5. 新身份 varchar(6) 可为null，'admin','sadmin','user'中间一个

#### 输出
6. 错误代码 0成功，1用户id不存在，2邮箱被占用，3手机号被占用，4密码格式错误

===============
## 删除用户
delete_user

### 参数列表

#### 输入
1. 用户id int 

#### 输出
2. 错误代码 0成功, 1用户id不存在

==================================================
# 分类相关
===============
## 返回所有分类
show_categories
  分类为一树状结构，由于分类不多，没写分页功能

### 无参数

===============
## 修改分类
change_category

### 参数列表

#### 输入
1. 分类id int unsigned 当前分类id
2. 新分类名 varchar(32) 新分类的名字
3. 新父类id int unsigned 新父分类的id

#### 输出
1. 错误代码 0成功，1分类id不存在，2父分类id不存在

===============
## 删除分类
delete_category
删除分类时将删除该分类下面所有的子分类

### 参数列表

#### 输入
1. 分类id int unsigned

#### 输出
1. 错误代码 0成功，1分类id不存在

===============
## 添加分类
add_category
添加一个分类

### 参数列表

#### 输入
1. 新分类名 varchar(32)
2. 父分类id int unsigned

#### 输出
1. 错误代码 0成功，1分类名已存在，2父分类id不存在

==================================================
# 评论相关
===============
## 返回所有评论
show_comments

### 参数列表

#### 输入
1. 页码 int 第几页
2. 页大小 int 一页显示多少条

#### 输出
3. 错误代码 0成功, 1失败(页码和页大小不对)

===============
## 删除评论
delete_category
删除评论及该评论下的所有评论

### 参数列表

#### 输入
1. 评论id

#### 输出
1. 错误代码 0成功，1评论id不存在

==================================================
# 专辑相关
===============
## 显示专辑
show_albums
显示专辑的所有内容，可分页

### 参数列表

#### 输入
1. 页码
2. 页大小

#### 输出
1. 错误代码 0成功，1页码或页大小错误