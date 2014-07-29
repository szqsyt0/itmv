<?php
/**
 * 用户模型，所有与用户相关的操作全部包含。
 * 最后修改时间：2014-07-29
 * 函数：
 * login(array)			登录，		返回array(id,name,email,identity,lastlogin,status)
 * get_info(array)		获取全部信息	返回array()
 * register(array)		注册，		返回array(id,name,email,identity,lastlogin,status)
 * change_password(array)	修改密码，	返回true/false值
 * change_userinfo(array)	修改信息，	返回错误信息或true
 * delete(array)		删除用户，	返回true/false值
 *
 */
class User_model extends CI_Model {

	function __construct() {
		parent::__construct();
	}

	/**
	 * 判断$data里是否设置了$required里的项，和是否非空，
	 * 若没设置或为空则返回false
	 *
	 * @param array $required
	 * @param array $data
	 * @return bool
	 */
	private function _required($required, $data)
	{
		foreach($required as $field)
			if(!isset($data[$field]) || $data[$field] == '')
				return false;
		return true;
	}

	/**
	 * _default method combines the options array with a set of defaults giving the values
	 * in the options array priority.
	 *
	 * @param array $defaults
	 * @param array $options
	 * @return array
	 */
	private function _default($defaults, $options)
	{
		return array_merge($defaults, $options);
	}

	/**
	 * 使用数组返回出错信息
	 *
	 * @param string $errinfo
	 * @return array
	 */
	private function _error($errinfo)
	{
		return array('error' => $errinfo);
	}

	/**
	 * 登录方法，可以用用户名或邮箱登录。
	 * 最后修改时间：2014-07-29
	 *
	 * Option: Values
	 * --------------------------
	 * name		user name
	 * email	user email
	 * password	sha512加密后的128位密码
	 *
	 * Returns (array of string)
	 * --------------------------
	 * id		user id
	 * name		user name
	 * email	user email
	 * identity	('user','admin','sadmin')之一
	 * lastlogin	lastlogin date string
	 * status	('normal','nocomment','nologin')之一
	 * error	若出错了则返回error
	 *
	 * @param array $options
	 * @return array
	 */
	function login($options = array()) {
		// 检查输入数据
		$login_by = '';
		if ($this->_required(array('name'),$options))
			$login_by = 'name';
		if ($this->_required(array('email'),$options))
			$login_by = 'email';
		if ($login_by == '')
			return $this->_error('Both user_name and user_email are not set.');
		if (!$this->_required(array('password'),$options))
			return $this->_error('password is empty.');

		// 执行查询
		$query = $this->db->get_where('user', array($login_by => $options[$login_by]));
		$result = $query->row_array(1);
		// 检测用户存在
		if (!$result)
			return $this->_error($login_by . ' ' . $options[$login_by] . ' not found');
		// 验证密码
		if ($options['password'] != $result['password'])
			return $this->_error('Wrong Password.');

		// 检测状态
		if ($result['status'] == -1)
			return $this->_error('This user is not allowed to login.');

		// 登录成功，修改最后登录时间
		date_default_timezone_set('Asia/Shanghai');
		$data = array('lastlogin' => date('Y-m-d'));
		$this->db->where('id', $result['id']);
		$this->db->update('user',$data);

		// 处理登录结果
		//unset($result[$login_by]);
		unset($result['password']);
		switch ($result['identity']) {
			case '0': $result['identity'] = 'user';break;
			case '1': $result['identity'] = 'admin';break;
			case '2': $result['identity'] = 'sadmin';break;
			default: $result['identity'] = 'user';
		}
		switch ($result['status']) {
			case '0': $result['status'] = 'normal';break;
			case '1': $result['status'] = 'nocomment';break;
			default: $result['status'] = 'normal';
		}
		return $result;
	}

	/**
	 * GetUsers method returns an array of qualified user record objects
	 *
	 * Option: Values
	 * --------------
	 * id
	 * email
	 * status
	 * limit      limits the number of returned records
	 * offset     how many records to bypass before returning a record (limit required)
	 * sortBy         determines which column the sort takes place
	 * sortDirection  (asc, desc) sort ascending or descending (sortBy required)
	 *
	 * Returns (array of objects)
	 * --------------------------
	 * id
	 * email
	 * name
	 * status
	 * identity
	 * lastlogin
	 *
	 * @param array $options
	 * @return array result()
	 */
	function GetUsers($options = array())
	{
		// default values
		$options = $this->_default(array('sortDirection' => 'asc'), $options);

		// Add where clauses to query
		$qualificationArray = array('id', 'email', 'status');
		foreach($qualificationArray as $qualifier)
		{
			if(isset($options[$qualifier]))
			$this->db->where($qualifier, $options[$qualifier]);
		}

		// If limit / offset are declared (usually for pagination)
		// then we need to take them into account
		if(isset($options['limit']) && isset($options['offset']))
		$this->db->limit($options['limit'], $options['offset']);
		else if(isset($options['limit'])) $this->db->limit($options['limit']);

		// sort
		if(isset($options['sortBy']))
		$this->db->order_by($options['sortBy'], $options['sortDirection']);

		$query = $this->db->get('user');
		if($query->num_rows() == 0) return false;

		if(isset($options['id']) && isset($options['email']))
		{
			// If we know that we're returning a singular record,
		// then let's just return the object
			return $query->row(0);
		}
		else
		{
			// If we could be returning any number of records
		// then we'll need to do so as an array of objects
			return $query->result();
		}
	}
	/**
	 * Usage:
	 * $user_id = $this->user_model->AddUser($_POST);
	 * if($user_id)
	 * 	echo "The user you have created has been added successfully with ID #" . $user_id;
	 * else
	 * 	echo "There was an error adding your user.";
	 */

}
?>
