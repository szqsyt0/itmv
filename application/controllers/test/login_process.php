<?php
class Login_process extends CI_Controller {
	function __construct() {
		parent::__construct();
	}

	public function index() {
		$this->output->enable_profiler(TRUE);
		$this->load->model('User_model');
		$shit = $this->User_model->login($_POST);
		if ($shit)
			echo var_dump($shit);
		else echo "FALSE";
	}
}
?>
