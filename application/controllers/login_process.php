<?php
class Login_process extends CI_Controller {
	function __construct() {
		parent::__construct();
	}

	public function index() {
		$this->output->enable_profiler(TRUE);
		echo $this->input->post('name').'</br>';
		$this->load->model('User_model');
		$shit = $this->User_model->login();
		if ($shit)
			echo $shit["id"].'</br>'.$shit["iden"];
		else echo "FALSE";
	}
}
?>
