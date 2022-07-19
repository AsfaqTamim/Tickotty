<?php
defined('BASEPATH') or exit('No direct script access allowed');

function CREATE_TOKEN($DATE)
{
	return substr(str_shuffle(str_repeat(md5($DATE), 10)), 0, 6);
}

function SET_COLOR($HEX, $STEP)
{
	$STEP = max(-255, min(255, $STEP));
	$HEX = str_replace('#', '', $HEX);
	if (strlen($HEX) == 3) {
		$HEX = str_repeat(substr($HEX, 0, 1), 2) . str_repeat(substr($HEX, 1, 1), 2) . str_repeat(substr($HEX, 2, 1), 2);
	}
	$color_parts = str_split($HEX, 2);
	$return = '#';
	foreach ($color_parts as $color) {
		$color = hexdec($color);
		$color = max(0, min(255, $color + $STEP));
		$return .= str_pad(dechex($color), 2, '0', STR_PAD_LEFT);
	}
	return $return;
}

function SLA_VIOLATED($STATUS, $ID)
{
	$CI = &get_instance();
	$VIOLATION = $CI->db->get_where('SLA_VIOLATIONS', array('TICKET_ID' => $ID, 'VIOLATION_TYPE' => $STATUS))->row_array();
	if ($VIOLATION) {
		return $VIOLATION;
	} else {
		return null;
	}
}

function GET_FIRST_ROW($TABLE, $WHERE_OPTIONS)
{
	$CI = &get_instance();
	return $CI->db->select('*')->order_by('ID', "ASC")->limit(1)->get_where($TABLE, $WHERE_OPTIONS)->row_array();
}

function CALCULATE_DUE_BY_PERIOD($PERIOD, $TIME, $VALUE)
{
	switch ($PERIOD) {
		case 1:
			$ADD = '+ ' . $TIME . ' mins';
			break;
		case 2:
			$ADD = '+ ' . $TIME . ' hours';
			break;
		case 3:
			$ADD = '+ ' . $TIME . ' days';
			break;
		case 4:
			$ADD = '+ ' . $TIME . ' months';
			break;
	}
	$SLA_RESPOND_TIME = $VALUE;
	return date("Y-m-d H:i:s", strtotime($ADD, strtotime($SLA_RESPOND_TIME)));
}

function CALCULATE_ESCALATE($ESCALATE, $STAMP)
{
	switch ($ESCALATE) {
		case 1:
			return date("Y-m-d H:i:s");
			break;
		case 2:
			return date("Y-m-d H:i:s", strtotime('+ 30 mins', strtotime($STAMP)));
			break;
		case 3:
			return date("Y-m-d H:i:s", strtotime('+ 1 hours', strtotime($STAMP)));
			break;
		case 4:
			return date("Y-m-d H:i:s", strtotime('+ 2 hours', strtotime($STAMP)));
			break;
		case 5:
			return date("Y-m-d H:i:s", strtotime('+ 4 hours', strtotime($STAMP)));
			break;
		case 6:
			return date("Y-m-d H:i:s", strtotime('+ 8 hours', strtotime($STAMP)));
			break;
		case 7:
			return date("Y-m-d H:i:s", strtotime('+ 12 hours', strtotime($STAMP)));
			break;
		case 8:
			return date("Y-m-d H:i:s", strtotime('+ 1 days', strtotime($STAMP)));
			break;
		case 9:
			return date("Y-m-d H:i:s", strtotime('+ 2 days', strtotime($STAMP)));
			break;
		case 10:
			return date("Y-m-d H:i:s", strtotime('+ 3 days', strtotime($STAMP)));
			break;
		case 11:
			return  date("Y-m-d H:i:s", strtotime('+ 1 weeks', strtotime($STAMP)));
			break;
		case 12:
			return  date("Y-m-d H:i:s", strtotime('+ 2 weeks', strtotime($STAMP)));
			break;
		case 13:
			return date("Y-m-d H:i:s", strtotime('+ 1 months', strtotime($STAMP)));
			break;
	}
}

function WEEK_DAYS()
{
	return array(
		'Monday',
		'Tuesday',
		'Wednesday',
		'Thursday',
		'Friday',
		'Saturday',
		'Sunday',
	);
}


function WEEK_DAYS_CODE()
{
	return array(
		array('NAME' => GET_PHRASE('Monday'), 'CODE' => 'Monday'),
		array('NAME' => GET_PHRASE('Tuesday'), 'CODE' => 'Tuesday'),
		array('NAME' => GET_PHRASE('Wednesday'), 'CODE' => 'Wednesday'),
		array('NAME' => GET_PHRASE('Thursday'), 'CODE' => 'Thursday'),
		array('NAME' => GET_PHRASE('Friday'), 'CODE' => 'Friday'),
		array('NAME' => GET_PHRASE('Saturday'), 'CODE' => 'Saturday'),
		array('NAME' => GET_PHRASE('Sunday'), 'CODE' => 'Sunday'),

	);
}

function APP_OPTIONS()
{
	$CI = &get_instance();
	$OPTIONS = $CI->db->get_where('OPTIONS', array('NAME' => 'APP'))->row_array();
	return $OPTIONS;
}

function GET_SLA_POLICY($TICKET_ID)
{
	$CI = &get_instance();
	$TICKET = $CI->db->get_where('TICKETS', array('ID' => $TICKET_ID))->row_array();
	if ($TICKET['SLA_POLICY']) {
		$SLA_POLICY = $CI->db->get_where('SLA_POLICIES', array('ID' => $TICKET['SLA_POLICY']))->row_array();
		$POLICY_DATA =  json_decode($SLA_POLICY['TARGETS'], true);
		$POLICY = array();
		foreach ($POLICY_DATA as $POLICY_IN) {
			if ($POLICY_IN['ID'] == $TICKET['PRIORITY']) {
				$POLICY = $POLICY_IN;
			}
		}
		$SLA_TYPES =  $POLICY['DATA'];
		$SLA_RESPOND = array();
		$SLA_RESOLVE = array();
		foreach ($SLA_TYPES as $TYPE) {
			if ($TYPE['NAME'] == 'RESPOND') {
				$SLA_RESPOND = $TYPE;
			}
			if ($TYPE['NAME'] == 'RESOLVE') {
				$SLA_RESOLVE = $TYPE;
			}
		}
		switch ($SLA_RESPOND['PERIOD']) {
			case 1:
				$ADD = '+ ' . $SLA_RESPOND['TIME'] . ' mins';
				break;
			case 2:
				$ADD = '+ ' . $SLA_RESPOND['TIME'] . ' hours';
				break;
			case 3:
				$ADD = '+ ' . $SLA_RESPOND['TIME'] . ' days';
				break;
			case 4:
				$ADD = '+ ' . $SLA_RESPOND['TIME'] . ' months';
				break;
		}

		$SLA_RESPOND_TIME = $TICKET['CREATED_DATE'];
		$SLA_RESPOND_STAMP = date("Y-m-d H:i:s", strtotime($ADD, strtotime($SLA_RESPOND_TIME)));

		switch ($SLA_RESOLVE['PERIOD']) {
			case 1:
				$ADD = '+ ' . $SLA_RESOLVE['TIME'] . ' mins';
				break;
			case 2:
				$ADD = '+ ' . $SLA_RESOLVE['TIME'] . ' hours';
				break;
			case 3:
				$ADD = '+ ' . $SLA_RESOLVE['TIME'] . ' days';
				break;
			case 4:
				$ADD = '+ ' . $SLA_RESOLVE['TIME'] . ' months';
				break;
		}

		$SLA_RESOLVE_TIME = $TICKET['CREATED_DATE'];
		$SLA_RESOLVE_STAMP = date("Y-m-d H:i:s", strtotime($ADD, strtotime($SLA_RESOLVE_TIME)));
		$VIOLATION_RULES =  json_decode($SLA_POLICY['VIOLATION_RULES'], true);
		$VIOLATION_RESPONSE = array();
		$VIOLATION_RESOLVE = array();
		foreach ($VIOLATION_RULES as $RULE) {
			if ($RULE['ID'] == 1) {
				$VIOLATION_RESPONSE = $RULE;
			}
			if ($RULE['ID'] == 2) {
				$VIOLATION_RESOLVE = $RULE;
			}
		}

		$VIOLATION_RESPOND_ALERT_DATE = CALCULATE_ESCALATE($VIOLATION_RESPONSE['ESCALATE'], $SLA_RESPOND_STAMP);
		$VIOLATION_RESOLVE_ALERT_DATE = CALCULATE_ESCALATE($VIOLATION_RESOLVE['ESCALATE'], $SLA_RESOLVE_STAMP);

		/*
		$DATE_NOW = date("Y-m-d H:i:s");
		if ($DATE_NOW > $VIOLATION_RESPOND_ALERT_DATE) {
			$RESPONSE_ALERTABLE = true;
		} else {
			$RESPONSE_ALERTABLE = false;
		}
		if ($DATE_NOW > $VIOLATION_RESOLVE_ALERT_DATE) {
			$RESOLVE_ALERTABLE = true;
		} else {
			$RESOLVE_ALERTABLE = false;
		}*/

		$RESULT =  array(
			'TICKET_ID' => $TICKET['ID'],
			'ASSIGNED_ID' => $TICKET['ASSIGNED_ID'],
			'RESPOND_DUE' => date(DATE_ISO8601, strtotime($SLA_RESPOND_STAMP)),
			'VIOLATION_RESPOND_ALERT_DATE' => date(DATE_ISO8601, strtotime($VIOLATION_RESPOND_ALERT_DATE)),
			'VIOLATION_RESPONSE_WARN_ASSIGNED'  => $VIOLATION_RESPONSE['WARN_ASSIGNED'],
			//'RESPONSE_ALERTABLE' => $RESPONSE_ALERTABLE,
			'RESOLVE_DUE' => date(DATE_ISO8601, strtotime($SLA_RESOLVE_STAMP)),
			'VIOLATION_RESOLVE_ALERT_DATE' => date(DATE_ISO8601, strtotime($VIOLATION_RESOLVE_ALERT_DATE)),
			'VIOLATION_RESOLVE_WARN_ASSIGNED'  => $VIOLATION_RESOLVE['WARN_ASSIGNED'],
			//'RESOLVE_ALERTABLE' => $RESOLVE_ALERTABLE,
		);
		return $RESULT;
	} else {
		return null;
	}
}
function HAS_PRIVILEGE($PATH)
{
	$CI = &get_instance();
	$CI->db->select('*,PERMISSIONS.KEY as PERMISSION_MAP');
	$CI->db->join('PERMISSIONS', 'PRIVILEGES.PERMISSION_ID = PERMISSIONS.ID', 'left');
	$rows = $CI->db->get_where('PRIVILEGES', array('PERMISSIONS.KEY' => $PATH, 'USER_ID' => $_SESSION['USER_ID']))->num_rows();
	return ($rows > 0) ? TRUE : FALSE;
}

function GET_PRIVILEGES()
{
	$CI = &get_instance();
	$query = $CI->db->get('PRIVILEGES');
	return $query->result_array();
}

function GET_ALL_PERMISSIONS()
{
	$CI = &get_instance();
	return $CI->db->get('PERMISSIONS')->result_array();
}

function GENERATE_USERNAME($DATA)
{
	$USERNME =  strstr($DATA, '@', true);
	$CI = &get_instance();
	$CHECK = $CI->db->get_where('USERS', array('USERNAME' => $USERNME))->row_array();
	if ($CHECK) {
		return $USERNME . rand(2, 50);
	} else {
		return $USERNME;
	}
}

function GET_STATS_BY_STAFF($ID)
{
	$CI = &get_instance();
	$TICKETS = $CI->db->get_where('TICKETS', array('ASSIGNED_ID' => $ID))->result_array();
	$CLOSED_TICKETS = $CI->db->get_where('TICKETS', array('STATUS', 4, 'ASSIGNED_ID', $ID))->result_array();
	foreach ($TICKETS as $TICKET) {
		$RESPONSE = GET_FIRST_ROW('CONVERSATIONS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']));
		if ($RESPONSE) {
			$RESPOND_DURATION = date_diff(date_create($TICKET['CREATED_DATE']), date_create($RESPONSE['DATE']));
			$AVERAGE[] = $RESPOND_DURATION->format('%H:%i:%s');
			$AVERAGE_RESPOND_TIME = date('H:i:s', array_sum(array_map('strtotime', $AVERAGE)) / count($AVERAGE));
		}
	}
	foreach ($CLOSED_TICKETS as $TICKET) {
		$RESOLVE_DURATION = date_diff(date_create($TICKET['CREATED_DATE']), date_create($TICKET['CLOSED_DATE']));
		$AVERAGE[] = $RESOLVE_DURATION->format('%H:%i:%s');
		$AVERAGE_RESOLVE_TIME = date('H:i:s', array_sum(array_map('strtotime', $AVERAGE)) / count($AVERAGE));
	}
	$STATS = array(
		'TOTAL_TICKET_COUNTS' => $CI->db->get_where('TICKETS', array('ASSIGNED_ID' => $ID))->num_rows(),
		'OPEN_TICKET_COUNTS' => $CI->db->get_where('TICKETS', array('STATUS' => 1, 'ASSIGNED_ID' => $ID))->num_rows(),
		'IN_PROGRESS_TICKET_COUNTS' => $CI->db->get_where('TICKETS', array('STATUS' => 2, 'ASSIGNED_ID' => $ID))->num_rows(),
		'REPLIED_TICKET_COUNTS' => $CI->db->get_where('TICKETS', array('STATUS' => 3, 'ASSIGNED_ID' => $ID))->num_rows(),
		'CLOSED_TICKET_COUNTS' => $CI->db->get_where('TICKETS', array('STATUS' => 4, 'ASSIGNED_ID' => $ID))->num_rows(),
		'AVERAGE_RESPOND_TIME' => (isset($AVERAGE_RESPOND_TIME)) ? $AVERAGE_RESPOND_TIME : 0,
		'AVERAGE_RESOLVE_TIME' => (isset($AVERAGE_RESOLVE_TIME)) ? $AVERAGE_RESOLVE_TIME : 0,
	);
	return $STATS;
}

function SEND_EMAIL_TO($TO, $SUBJECT, $MESSAGE)
{
	$CI = &get_instance();
	$OPTIONS = $CI->db->get_where('OPTIONS', array('NAME' => 'APP'))->row_array();
	$CI->load->library('email');
	$CI->email->initialize(array(
		'protocol' => 'smtp',
		'smtp_host' => $OPTIONS['SMTP_HOST'],
		'smtp_user' => $OPTIONS['SMTP_USER'],
		'smtp_pass' => $OPTIONS['SMTP_PASS'],
		'smtp_port' => $OPTIONS['SMTP_PORT'],
		'crlf' => "\r\n",
		'newline' => "\r\n"
	));
	$CI->email->set_newline("\r\n");
	$CI->email->set_mailtype("html");
	$CI->email->from($OPTIONS['NO_REPLY_EMAIL'], $OPTIONS['APPLICATION_NAME']);
	$CI->email->to($TO);
	$CI->email->subject($SUBJECT);
	$CI->email->message($MESSAGE);
	if ($CI->email->send()) {
		return true;
	} else {
		return false;
	}
}

function GET_PHRASE($phrase)
{
	$CI = &get_instance();
	$CI->load->database();
	$OPTIONS = $CI->db->get_where('OPTIONS', array('NAME' => 'APP'))->row_array();
	$KEY = preg_replace('/\s+/', '_', $phrase);
	if (!$CI->session->userdata('LOGGED_IN')) {
		$LANG = json_decode(file_get_contents('../assets/translations/lang_' . $OPTIONS['LANG'] . '.json'), true);
	} else {
		$USER = $CI->db->get_where('USERS', array('ID' => $_SESSION['USER_ID']))->row_array();
		$LANG = json_decode(file_get_contents('../assets/translations/lang_' . $USER['LANGUAGE'] . '.json'), true);
	}
	return $LANG[$KEY];
}