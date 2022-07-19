<?php
defined('BASEPATH') or exit('No direct script access allowed');

class APP_Controller extends CI_Controller
{
	function __construct()
	{
		parent::__construct();
	}
}

class Authentication extends CI_Controller
{
	function __construct()
	{
		parent::__construct();
		$this->load->helper('security');
		$this->load->model('USER');
		date_default_timezone_set(APP_OPTIONS()['DEFAULT_TIME_ZONE']);
		
	}
}

class ApiService extends CI_Controller
{
	function __construct()
	{
		parent::__construct();
		$this->load->helper('security');
		$this->load->model('USER');
		date_default_timezone_set(APP_OPTIONS()['DEFAULT_TIME_ZONE']);
		if ((isset($_SESSION['LOGGED_IN']) && $_SESSION['LOGGED_IN'] === true)) {
			$this->output->set_status_header(200);
		} else {
			$response = array('STATUS' => 'UNAUTHORIZED');
			$this->output
				->set_status_header(401)
				->set_content_type('application/json', 'utf-8')
				->set_output(json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES))
				->_display();
			exit;
		}
	}
}

class CronJOB extends CI_Controller
{
	function __construct()
	{
		parent::__construct();
		$this->load->helper('security');
		date_default_timezone_set(APP_OPTIONS()['DEFAULT_TIME_ZONE']);
	}
}

class HomeCTRL extends CI_Controller
{
	function __construct()
	{
		parent::__construct();
		$this->load->helper('security');
		date_default_timezone_set(APP_OPTIONS()['DEFAULT_TIME_ZONE']);
	}
}