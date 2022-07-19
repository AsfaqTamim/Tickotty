<?php
defined('BASEPATH') or exit('No direct script access allowed');
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Methods: GET, OPTIONS");
class Auth extends Authentication
{
	function AUTHENTICATE()
	{
		$USER_LOGIN_DATA = $this->input->post('USERNAME');
		$PASSWORD = $this->input->post('PASSWORD');
		if (strpos($USER_LOGIN_DATA, '@') !== false) {
			$LOGIN_TYPE = false;
		} else {
			$LOGIN_TYPE = true;
		}
		switch ($LOGIN_TYPE) {
			case true:
				$LOGIN_RESULT = $this->USER->RESOLVE_USER_LOGIN($USER_LOGIN_DATA, $PASSWORD);
				break;
			case false:
				$LOGIN_RESULT = $this->USER->RESOLVE_USER_LOGIN_BY_EMAIL($USER_LOGIN_DATA, $PASSWORD);
				break;
		};
		if ($LOGIN_RESULT) {
			switch ($LOGIN_TYPE) {
				case true:
					$USER_ID = $this->USER->GET_USER_ID_FROM_USERNAME($USER_LOGIN_DATA);
					break;
				case false:
					$USER_ID = $this->USER->GET_USER_ID_FROM_EMAIL($USER_LOGIN_DATA);
					break;
			};
			$USER = $this->USER->GET_USER($USER_ID);
			$_SESSION['USER_ID'] = (int) $USER->ID;
			$_SESSION['EMAIL'] = (string) $USER->EMAIL;
			$_SESSION['TOKEN'] = (string) $USER->TOKEN;
			$_SESSION['CLIENT_ID'] =  $USER->CLIENT_ID;
			$_SESSION['NAME'] = (string) $USER->NAME;
			$_SESSION['SURNAME'] = (string) $USER->NAME;
			$_SESSION['USERNAME'] = (string) $USER->USERNAME;
			$_SESSION['LANGUAGE'] = (string) $USER->LANGUAGE;
			$_SESSION['LOGGED_IN'] = (bool) true;
			$_SESSION['STAFF'] = (string) $USER->STAFF;
			$_SESSION['ADMIN'] = (string) $USER->ADMIN;
			if ($USER->ACTIVE === 'false') {
				foreach ($_SESSION as $key => $value) {
					unset($_SESSION[$key]);
				}
				$this->output
					->set_status_header(401)
					->set_content_type('application/json', 'utf-8')
					->set_output(json_encode(array('STATUS' => 'UNAUTHORIZED', 'REASON' => 'NOT_ACTIVE'), JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES))
					->_display();
				exit;
			}
			$this->output
				->set_status_header(200)
				->set_content_type('application/json', 'utf-8')
				->set_output(json_encode(true, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES))
				->_display();
			$SESSIONED_USER = $USER = $this->db->get_where('USERS', array('ID' => $_SESSION['USER_ID']))->row_array();
			$LOG_DETAIL = sprintf(GET_PHRASE('LOG_USER_LOGGED_IN'), $SESSIONED_USER['NAME']);
			$this->db->insert('LOGS', array('USER_ID' => $_SESSION['USER_ID'], 'DETAIL' => $LOG_DETAIL));
			exit;
		} else {
			$this->output
				->set_status_header(401)
				->set_content_type('application/json', 'utf-8')
				->set_output(json_encode(false, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES))
				->_display();
			exit;
		}
	}

	function GET_USER_INFO()
	{
		if (isset($_SESSION['LOGGED_IN'])) {
			$USER = $this->db->get_where('USERS', array('ID' => $_SESSION['USER_ID']))->row_array();
			if ($USER['STAFF'] == 'true' ||  $USER['ADMIN'] == 'true') {
				$IS_ADMIN = true;
			} else {
				$IS_ADMIN = false;
			}
			$DATA_USER = array(
				'ID' => $USER['ID'],
				'LANGUAGE' => $USER['LANGUAGE'],
				'NAME' => $USER['NAME'],
				'SURNAME' => $USER['SURNAME'],
				'PHONE' => $USER['PHONE'],
				'TOKEN' => $USER['TOKEN'],
				'CLIENT_ID' => $USER['CLIENT_ID'],
				'ADDRESS' => $USER['ADDRESS'],
				'EMAIL' => $USER['EMAIL'],
				'USERNAME' => $USER['USERNAME'],
				'LANGUAGE' => $USER['LANGUAGE'],
				'STAFF' => $USER['STAFF'] == 'true' ? true : false,
				'ADMIN' => $USER['ADMIN'] == 'true' ? true : false,
				'IS_ADMIN' => $IS_ADMIN,
				'PERMISSIONS' => json_decode($USER['PERMISSIONS']),
			);
			$this->output
				->set_status_header(200)
				->set_content_type('application/json', 'utf-8')
				->set_output(json_encode($DATA_USER, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES))
				->_display();
			exit;
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

	function LOGOUT()
	{
		if (isset($_SESSION['LOGGED_IN']) && $_SESSION['LOGGED_IN'] === true) {
			foreach ($_SESSION as $key => $value) {
				unset($_SESSION[$key]);
			}
			echo true;
		} else {
			echo false;
		}
	}

	function GET_AUTH()
	{
		if (isset($_SESSION['LOGGED_IN'])) {
			$USER = $this->db->get_where('USERS', array('ID' => $_SESSION['USER_ID']))->row_array();
			if ($USER['STAFF'] == 'true' ||  $USER['ADMIN'] == 'true') {
				$IS_ADMIN = true;
			} else {
				$IS_ADMIN = false;
			}
			$DATA_USER = array(
				'ID' => $USER['ID'],
				'LANGUAGE' => $USER['LANGUAGE'],
				'NAME' => $USER['NAME'],
				'SURNAME' => $USER['SURNAME'],
				'PHONE' => $USER['PHONE'],
				'TOKEN' => $USER['TOKEN'],
				'CLIENT_ID' => $USER['CLIENT_ID'],
				'ADDRESS' => $USER['ADDRESS'],
				'EMAIL' => $USER['EMAIL'],
				'USERNAME' => $USER['USERNAME'],
				'LANGUAGE' => $USER['LANGUAGE'],
				'STAFF' => $USER['STAFF'] == 'true' ? true : false,
				'ADMIN' => $USER['ADMIN'] == 'true' ? true : false,
				'IS_ADMIN' => $IS_ADMIN,
				'PERMISSIONS' => json_decode($USER['PERMISSIONS']),
			);
			$this->output
				->set_status_header(200)
				->set_content_type('application/json', 'utf-8')
				->set_output(json_encode($DATA_USER, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES))
				->_display();
			exit;
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

	public function GET_OPTIONS()
	{
		$OPTIONS = $this->db->get_where('OPTIONS', array('NAME' => 'APP'))->row_array();
		$DATA_OPTIONS = array(
			'NAME' => $OPTIONS['NAME'],
			'HELPDESK_STATUS' => $OPTIONS['HELPDESK_STATUS'],
			'VACATION_MODE' => $OPTIONS['VACATION_MODE'] == 'true' ? true : false,
			'DEFAULT_DEPARTMENT' => $OPTIONS['DEFAULT_DEPARTMENT'],
			'APPLICATION_NAME' => $OPTIONS['APPLICATION_NAME'],
			'APP_COLOR' => $OPTIONS['APP_COLOR'],
			'MAX_PAGE_SIZE' => (int)$OPTIONS['MAX_PAGE_SIZE'],
			'DEFAULT_LOCALE' => (int)$OPTIONS['DEFAULT_LOCALE'],
			'SMTP_HOST' => $OPTIONS['SMTP_HOST'],
			'DESK_URL' =>  $OPTIONS['DESK_URL'],
			'SMTP_PORT' => $OPTIONS['SMTP_PORT'],
			'DEFAULT_TIME_ZONE' => $OPTIONS['DEFAULT_TIME_ZONE'],
			'LANG' => $OPTIONS['LANG'],
			'BUSINESS_HOURS' =>  json_decode($OPTIONS['BUSINESS_HOURS'], true),
		);
		echo json_encode($DATA_OPTIONS);
	}

	public function GET_APP_COLORS()
	{
		$OPTIONS = $this->db->get_where('OPTIONS', array('NAME' => 'APP'))->row_array();
		$COLOR = $OPTIONS['APP_COLOR'];
		$COLORS = array(
			'PRIMARY_COLOR' => $COLOR,
			'SECONDARY_COLOR' => SET_COLOR($COLOR, -15),
			'TERTIARY_COLOR' => SET_COLOR($COLOR, 5),
			'FOURTH_COLOR' => SET_COLOR($COLOR, 50),
		);
		echo json_encode($COLORS);
	}

	function CREATE_ACCOUNT()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$DATA = array(
				'NAME' => $_POST['NAME'],
				'TOKEN' => CREATE_TOKEN(date('Y-m-d H:i:s')),
				'SURNAME' => $_POST['SURNAME'],
				'EMAIL' => $_POST['EMAIL'],
				'USERNAME' => GENERATE_USERNAME($_POST['EMAIL']),
				'PASSWORD' => password_hash($_POST['PASSWORD'], PASSWORD_BCRYPT)
			);
			$this->db->insert('USERS', $DATA);
			$USER_ID = $this->db->insert_id();
			//CREATE PRIVILEGES
			$PRIVILEGES = json_decode($_POST['PRIVILEGES'], true);
			$i = 0;
			foreach ($PRIVILEGES as $PRIVILEGE) {
				if ($PRIVILEGE['VALUE'] == true) {
					$this->db->insert('PRIVILEGES', array(
						'USER_ID' => (int) $USER_ID,
						'PERMISSION_ID' => (int) $PRIVILEGE['ID']
					));
				}
				$i++;
			};
			//CREATE PRIVILEGES
			echo json_encode(true);
		}
	}

	function CHECK_PRIVILEGE()
	{
		if (HAS_PRIVILEGE($_POST['PATH'])) {
			$this->output
				->set_status_header(200)
				->set_content_type('application/json', 'utf-8')
				->set_output(json_encode(true, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES))
				->_display();
			exit;
		} else {
			$this->output
				->set_status_header(403)
				->set_content_type('application/json', 'utf-8')
				->set_output(json_encode(false, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES))
				->_display();
			exit;
		}
	}

	function FORGOT_PASSWORD()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$EMAIL = $this->input->post('EMAIL');
			if ((strpos($EMAIL, '@') !== false)) {
				$this->load->library('email');
				$clean = $this->security->xss_clean($EMAIL);
				$USER_INFO = $this->USER->GET_USER_BY_EMAIL($clean);
				if ($USER_INFO) {
					$TOKEN = $this->USER->INSERT_TOKEN($USER_INFO->ID);
					$USER_NAME = $USER_INFO->NAME;
					$C_URL = APP_OPTIONS()['DESK_URL'] . '#!/reset-password/' . $TOKEN;
					$SUBJECT = GET_PHRASE('EMAIL_PASSWORD_CHANGE_REQUEST_TITLE');
					$TO = $USER_INFO->EMAIL;
					$DATA = array(
						'NAME' => $USER_NAME,
						'EMAIL' => $USER_INFO->EMAIL,
						'URL' => $C_URL,
					);
					$BODY = $this->load->view('email/RESET_PASSWORD.php', $DATA, TRUE);
					$RESULT = SEND_EMAIL_TO($TO, $SUBJECT, $BODY);
					if ($RESULT) {
						echo 1;
					} else {
						echo 2;
					}
				} else {
					echo 3;
				}
			} else {
				echo 4;
			}
		} else {
			echo 5;
		}
	}

	public function RESET_PASSWORD()
	{
		$TOKEN = $this->input->post('TOKEN');
		$cleanToken = $this->security->xss_clean($TOKEN);
		$USER_INFO = $this->USER->isTokenValid($cleanToken); //either false or array();               
		if (!$USER_INFO) {
			$this->session->set_flashdata('mesaj', 'Bağlantı zaman aşımına uğradı.');
			$this->session->set_flashdata('renk', 'danger');
			echo 'false';
		}
		$this->form_validation->set_rules('password', 'Password', 'required|min_length[5]');
		$this->form_validation->set_rules('passconf', 'Password Confirmation', 'required|matches[password]');

		if ($this->form_validation->run() == FALSE) {
			echo 'false';
		} else {
			$POST = $this->input->post(NULL, TRUE);
			$CLEAN_POST = $this->security->xss_clean($POST);
			$HASHED = $CLEAN_POST['password'];
			$CLEAN_POST['PASSWORD'] = $HASHED;
			$CLEAN_POST['USER_ID'] = $USER_INFO->ID;
			unset($CLEAN_POST['passconf']);
			if (!$this->USER->updatePassword($CLEAN_POST)) {
				echo 'false';
			} else {
				echo 'true';
			}
		}
	}

	public function base64url_encode($data)
	{
		return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
	}
	public function base64url_decode($data)
	{
		return base64_decode(str_pad(strtr($data, '-_', '+/'), strlen($data) % 4, '=', STR_PAD_RIGHT));
	}
}
