<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Login extends CI_Controller {
        
	public function index()
	{
            $this->load->view('login');
	}
        
        public function CheckLogin()
        {    
            $this->load->model('user_model');
            $user = array();            
            if(preg_match("/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/", trim($_POST['name'])))
            {   //邮箱登陆
                $user['email'] = addslashes(trim($_POST['name']));
            }else
            {  //非邮箱登陆
                $user['name'] = addslashes(trim($_POST['name']));
            }
            $user['password'] = addslashes(trim($_POST['password']));
            //登陆验证
            $result = $this->user_model->login($user);
            
            if(array_key_exists('error',$result))
            {
                //登陆失败，跳转回登陆界面，提示错误信息
                $this->load->view('login',$result);
            }
            else
            {
                //登陆成功,将用户信息添加到session
                $this->session->set_userdata($result);
                //跳转到管理界面
                $this->load->view('manage',$result);
            }
            
        }
}