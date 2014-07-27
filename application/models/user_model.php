<?php
/**
 * 用户模型，所有与用户相关的操作全部包含。
 * 函数：
 * login()		登录，		返回false或array("id","iden")
 * register()		注册，		返回错误信息或true
 * change_password()	修改密码，	返回true/false值
 * get_info()		获取全部信息
 * change_userinfo()	修改信息，	返回错误信息或true
 * delete()		删除用户，	返回true/false值
 * 
 */
class User_model extends CI_Model {
	var $id = '';
	var $name = '';
	var $pass = '';
	var $email = '';
	var $identity = '';
	var $lastlogin = '';
	var $status = '';
	var $showname = '';
	var $sex = '';
	var $phone = '';

	function __construct() {
		parent::__construct();
	}

	function login() {
		// 使用imput类接收name,password
		$this->name = $this->input->post('name');
		$this->pass = $this->input->post('pass');

		// 执行存储过程
		$sql = "call login('$this->name','$this->pass',@id, @iden, @err)";
		// 手动载入数据库类
		$this->load->database();
		$query = $this->db->query($sql);
		$result = $this->db->query("select @id as id, @iden as iden, @err as err");
		// 手动关闭数据库连接
		$this->db->close();
		$rows = $result->row();
		// 登录失败直接返回false
		if ($rows->err != 0) {
			return false;
		}
		// 登录成功

		return array (
			"id" => $rows->id,
			"iden" => $rows->iden,
		);
	}
}
?>
