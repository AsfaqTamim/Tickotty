<?php
defined('BASEPATH') or exit('No direct script access allowed');
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Methods: GET, OPTIONS");
class Api extends ApiService
{
	function index()
	{
		$DATA = array(
			'NAME' => 'Tickotty',
			'VERSION' => '1.0.0',
			'RESOURCE_URL' => base_url(),
			'SUPPORTS' => 'Post & Get Methods',
			'DATE' => date('H:i:s'),
		);
		echo json_encode($DATA);
	}

	function GET_LEFT_MENU()
	{
		$ALL_LEFT_MENU = $this->db->order_by("ORDER", "asc")->get_where('ADMIN_PANEL_MENU', array('MAIN_MENU_ID' => 0))->result_array();
		$DATA_LEFT_MENU = array();
		foreach ($ALL_LEFT_MENU as $MENU) {
			$SUB_MENUS = $this->db->get_where('ADMIN_PANEL_MENU', array('MAIN_MENU_ID' => $MENU['ID']))->result_array();
			if ($SUB_MENUS) {
				$SUB = $SUB_MENUS;
			} else {
				$SUB = null;
			}
			if (HAS_PRIVILEGE($MENU['PATH']) || $MENU['SHOW'] != 'false') {
				$SHOW = true;
			} else {
				$SHOW = false;
			}
			$DATA_LEFT_MENU[] = array(
				'ID' => $MENU['ID'],
				'TITLE' => GET_PHRASE($MENU['PATH']),
				'URL' => $MENU['URL'],
				'ICON' => $MENU['ICON'],
				'PATH' => $MENU['PATH'],
				'SUB' => $SUB,
				'SHOW' => $SHOW
			);
		}
		echo json_encode($DATA_LEFT_MENU);
	}

	function GET_USER_NOTIFICATIONS()
	{
		$NOTIFICATIONS = $this->db->order_by("ID", "DESC")->get_where('NOTIFICATIONS', array('RECEIVER' => $_SESSION['USER_ID']))->result_array();
		$DATA_NOTIFICATIONS = array();
		foreach ($NOTIFICATIONS as $NOTIFICATION) {
			switch ($NOTIFICATION['RELATION_TYPE']) {
				case 'TICKET':
					$ICON = 'assets/icons/assigned.svg';
					break;
				case 'false' || null:
					$ICON = 'assets/icons/flash.svg';
					break;
			}
			$DATA_NOTIFICATIONS[] = array(
				'READ' => $NOTIFICATION['READ'] == 'true' ? true : false,
				'DATE' => date(DATE_ISO8601, strtotime($NOTIFICATION['DATE'])),
				'ID' => (int) $NOTIFICATION['ID'],
				'TITLE' => $NOTIFICATION['TITLE'],
				'DETAIL' => $NOTIFICATION['DETAIL'],
				'RELATION_TYPE' => $NOTIFICATION['RELATION_TYPE'],
				'RELATED_ID' => $NOTIFICATION['RELATED_ID'],
				'RECEIVER' => $NOTIFICATION['RECEIVER'],
				'ICON' => $ICON,
			);
		};
		echo json_encode($DATA_NOTIFICATIONS);
	}

	function MARK_NOTIFICATION_AS_READ()
	{
		if ($this->input->post('NTF_ID')) {
			$this->db->where('ID', $this->input->post('NTF_ID'))->update('NOTIFICATIONS', array('READ' => 'true'));
			echo 'true';
		} else {
			echo 'false';
		}
	}

	function MARK_NOTIFICATION_AS_ALL_READ()
	{
		$this->db->where('RECEIVER', $_SESSION['USER_ID'])->update('NOTIFICATIONS', array('READ' => 'true'));
		echo 'true';
	}

	function GET_LOCALES()
	{
		return include('../assets/json/timezones.json');
	}

	function GET_STATS()
	{
		if ($_SESSION["ADMIN"] == 'false' && $_SESSION["STAFF"] == 'false') {
			if (is_null($_SESSION['CLIENT_ID'])) {
				$CLIENT = $_SESSION['TOKEN'];
			} else {
				$CLIENT = $_SESSION['CLIENT_ID'];
			}
			$TICKETS = $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT))->result_array();
			$CLOSED_TICKETS = $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT, 'STATUS' => 4))->result_array();
			if ($TICKETS) {
				foreach ($TICKETS as $TICKET) {
					$RESPONSE = GET_FIRST_ROW('CONVERSATIONS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']));
					if ($RESPONSE) {
						$RESPOND_DURATION = date_diff(date_create($TICKET['CREATED_DATE']), date_create($RESPONSE['DATE']));
						$AVERAGE[] = $RESPOND_DURATION->format('%H:%i:%s');
						$AVERAGE_RESPOND_TIME = date('H:i:s', array_sum(array_map('strtotime', $AVERAGE)) / count($AVERAGE));
					}
				}
			}
			if ($CLOSED_TICKETS) {
				foreach ($CLOSED_TICKETS as $TICKET) {
					$RESOLVE_DURATION = date_diff(date_create($TICKET['CREATED_DATE']), date_create($TICKET['CLOSED_DATE']));
					$AVERAGE[] = $RESOLVE_DURATION->format('%H:%i:%s');
					$AVERAGE_RESOLVE_TIME = date('H:i:s', array_sum(array_map('strtotime', $AVERAGE)) / count($AVERAGE));
				}
			}
			$STATS = array(
				'TOTAL_TICKET_COUNTS' => $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT))->num_rows(),
				'OPEN_TICKET_COUNTS' => $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT, 'STATUS' => 1))->num_rows(),
				'IN_PROGRESS_TICKET_COUNTS' => $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT, 'STATUS' => 2))->num_rows(),
				'REPLIED_TICKET_COUNTS' => $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT, 'STATUS' => 3))->num_rows(),
				'CLOSED_TICKET_COUNTS' => $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT, 'STATUS' => 4))->num_rows(),
				'AVERAGE_RESPOND_TIME' => (isset($AVERAGE_RESPOND_TIME)) ? $AVERAGE_RESPOND_TIME : 0,
				'AVERAGE_RESOLVE_TIME' => (isset($AVERAGE_RESOLVE_TIME)) ? $AVERAGE_RESOLVE_TIME : 0,
			);
			echo json_encode($STATS);
		} else {
			$TICKETS = $this->db->get_where('TICKETS')->result_array();
			$CLOSED_TICKETS = $this->db->get_where('TICKETS', array('STATUS' => 4))->result_array();
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
				'TOTAL_TICKET_COUNTS' => $this->db->from('TICKETS')->get()->num_rows(),
				'OPEN_TICKET_COUNTS' => $this->db->from('TICKETS')->where('STATUS', 1)->get()->num_rows(),
				'IN_PROGRESS_TICKET_COUNTS' => $this->db->from('TICKETS')->where('STATUS', 2)->get()->num_rows(),
				'REPLIED_TICKET_COUNTS' => $this->db->from('TICKETS')->where('STATUS', 3)->get()->num_rows(),
				'CLOSED_TICKET_COUNTS' => $this->db->from('TICKETS')->where('STATUS', 4)->get()->num_rows(),
				'AVERAGE_RESPOND_TIME' => (isset($AVERAGE_RESPOND_TIME)) ? $AVERAGE_RESPOND_TIME : 0,
				'AVERAGE_RESOLVE_TIME' => (isset($AVERAGE_RESOLVE_TIME)) ? $AVERAGE_RESOLVE_TIME : 0,
				'TOTAL_CLIENTS_COUNTS' => $this->db->get_where('USERS', array('ADMIN' => 'false', 'STAFF' => 'false', 'CLIENT_ID' => null))->num_rows(),
				'SUSPENDED_CLIENTS_COUNTS' => $this->db->get_where('USERS', array('ACTIVE' => 'false', 'ADMIN' => 'false', 'STAFF' => 'false', 'CLIENT_ID' => null))->num_rows(),
			);
			echo json_encode($STATS);
		}
	}

	function GET_SOLVED_UNSOLVED_GRAHP()
	{
		$GRAPH = array();

		if ($_SESSION['STAFF'] == 'true' ||  $_SESSION['ADMIN'] == 'true') {
			$TOTAL = $this->db->from('TICKETS')->where('WEEK(TICKETS.CREATED_DATE ) = WEEK(CURRENT_DATE)')->get()->num_rows();
			foreach (WEEK_DAYS_CODE() as $DAY) {
				$SOLVED = $this->db->from('TICKETS')->where('CAST(TICKETS.CLOSED_DATE as DATE) = "' . date('Y-m-d', strtotime('' . $DAY['CODE'] . ' this week')) . '" AND TICKETS.STATUS = 4')->get()->num_rows();
				$WAITING = $this->db->from('TICKETS')->where('CAST(TICKETS.CREATED_DATE as DATE) = "' . date('Y-m-d', strtotime('' . $DAY['CODE'] . ' this week')) . '" AND TICKETS.STATUS != 4')->get()->num_rows();
				$GRAPH[] = array(
					'NAME' => $DAY['NAME'],
					'TOTAL' => $TOTAL,
					'SOLVED' => $SOLVED,
					'WAITING' => $WAITING,
				);
			}
		} else {
			if (is_null($_SESSION['CLIENT_ID'])) {
				$CLIENT = $_SESSION['TOKEN'];
			} else {
				$CLIENT = $_SESSION['CLIENT_ID'];
			}
			$this->db->select('*');
			$this->db->where('CLIENT', $CLIENT);
			$TOTAL = $this->db->from('TICKETS')->where('WEEK(TICKETS.CREATED_DATE ) = WEEK(CURRENT_DATE)')->get()->num_rows();
			foreach (WEEK_DAYS_CODE() as $DAY) {
				$SOLVED = $this->db->from('TICKETS')->where('CLIENT', $CLIENT)->where('CAST(TICKETS.CLOSED_DATE as DATE) = "' . date('Y-m-d', strtotime('' . $DAY['CODE'] . ' this week')) . '" AND TICKETS.STATUS = 4')->get()->num_rows();
				$WAITING = $this->db->from('TICKETS')->where('CLIENT', $CLIENT)->where('CAST(TICKETS.CREATED_DATE as DATE) = "' . date('Y-m-d', strtotime('' . $DAY['CODE'] . ' this week')) . '" AND TICKETS.STATUS != 4')->get()->num_rows();
				$GRAPH[] = array(
					'NAME' => $DAY['NAME'],
					'TOTAL' => $TOTAL,
					'SOLVED' => $SOLVED,
					'WAITING' => $WAITING,
				);
			}
		}

		echo json_encode($GRAPH);
	}

	function ASSIGNATED_STAFF_BASED_SOLIDARITY_APPLICATIONS_GRAHP()
	{
		$CONDITION = "(ADMIN='true' OR STAFF='true')";
		$this->db->select('*');
		$this->db->where($CONDITION);
		$ALL_STAFF = $this->db->get('USERS')->result_array();
		$TOTAL = $this->db->where('ASSIGNED_ID != 0')->count_all_results('TICKETS');
		foreach ($ALL_STAFF as $STAFF) {
			$COUNT = $this->db->where('ASSIGNED_ID', $STAFF['ID'])->count_all_results('TICKETS');
			$GRAPH[] = array(
				'STAFF_NAME' => $STAFF['NAME'],
				'COUNT' => $COUNT,
				'TOTAL' => $TOTAL,
				'PERCENT' => ($TOTAL > 0 ? number_format(($COUNT * 100) / $TOTAL) : 0)
			);
		}
		echo json_encode($GRAPH);
	}

	function GET_CANNED_RESPONSES()
	{
		$CANNED_RESPONSES = $this->db->select('*')->get('CANNED_RESPONSES')->result_array();
		echo json_encode($CANNED_RESPONSES);
	}

	function GET_ALL_TODOS()
	{
		$ALL_TODOS = $this->db->get_where('TODO', array('USER_ID' => $_SESSION['USER_ID']))->result_array();
		echo json_encode($ALL_TODOS);
	}

	function CREATE_TODO()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$CONVERSATION_DETAIL = array(
				'DETAIL' => $this->input->post('DETAIL'),
				'USER_ID' => $_SESSION['USER_ID'],
			);
			$this->db->insert('TODO', $CONVERSATION_DETAIL);
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function REMOVE_TODO()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->delete('TODO', array('ID' => $this->input->post('ID')));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function CREATE_CANNED_RESPONSE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$DEPARTMENT_DETAIL = array(
				'NAME' => $this->input->post('NAME'),
				'MESSAGE' => $this->input->post('MESSAGE'),
			);
			$this->db->insert('CANNED_RESPONSES', $DEPARTMENT_DETAIL);
			$CANNED_RESPONSE = $this->db->get_where('CANNED_RESPONSES', array('ID' => $this->db->insert_id()))->row_array();
			$CANNED_RESPONSE_DATA = array(
				'ID' => (int) $CANNED_RESPONSE['ID'],
				'NAME' =>  $CANNED_RESPONSE['NAME'],
				'MESSAGE' =>  $CANNED_RESPONSE['MESSAGE'],
			);
			echo json_encode($CANNED_RESPONSE_DATA);
		} else {
			echo json_encode(false);
		}
	}

	function NEW_DEPARTMENT()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$DEPARTMENT_DETAIL = array(
				'NAME' => $this->input->post('NAME'),
			);
			$this->db->insert('DEPARTMENTS', $DEPARTMENT_DETAIL);
			$DEPARTMENT = $this->db->get_where('DEPARTMENTS', array('ID' => $this->db->insert_id()))->row_array();
			$DATA_DEPARTMENT = array(
				'ID' => (int) $DEPARTMENT['ID'],
				'NAME' =>  $DEPARTMENT['NAME'],
				'TOTAL_COUNTS' => $this->db->get_where('TICKETS', array('DEPARTMENT_ID' =>  $DEPARTMENT['ID']))->num_rows(),
			);
			echo json_encode($DATA_DEPARTMENT);
		} else {
			echo json_encode(false);
		}
	}

	function RENAME_DEPARTMENT()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->where('ID', $this->input->post('ID'))->update('DEPARTMENTS', array('NAME' => $this->input->post('NAME')));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function REMOVE_DEPARTMENT()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->delete('DEPARTMENTS', array('ID' => $this->input->post('ID')));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function NEW_PROCESSES()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$NUM = $this->db->get_where('PROCESSES', array('DEPARTMENT_ID' =>  $this->input->post('DEPARTMENT_ID')))->num_rows();
			$DEPARTMENT_DETAIL = array(
				'NAME' => $this->input->post('NAME'),
				'ORDER' => $NUM + 1,
				'DEPARTMENT_ID' => $this->input->post('DEPARTMENT_ID'),
			);
			return $this->db->insert('PROCESSES', $DEPARTMENT_DETAIL);
		} else {
			echo json_encode(false);
		}
	}

	function RENAME_PROCESSES()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->where('ID', $this->input->post('ID'))->update('PROCESSES', array('NAME' => $this->input->post('NAME')));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function REMOVE_PROCESSES()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->delete('PROCESSES', array('ID' => $this->input->post('ID')));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function NEW_CATEGORY()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$CATEGORY_DETAIL = array(
				'NAME' => $this->input->post('NAME'),
			);
			$this->db->insert('ARTICLE_CATEGORIES', $CATEGORY_DETAIL);
			$CATEGORY = $this->db->get_where('ARTICLE_CATEGORIES', array('ID' => $this->db->insert_id()))->row_array();
			$DATA_CATEGORY = array(
				'ID' => (int) $CATEGORY['ID'],
				'NAME' =>  $CATEGORY['NAME'],
			);
			echo json_encode($DATA_CATEGORY);
		} else {
			echo json_encode(false);
		}
	}

	function RENAME_CATEGORY()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->where('ID', $this->input->post('ID'))->update('ARTICLE_CATEGORIES', array('NAME' => $this->input->post('NAME')));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function REMOVE_CATEGORY()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->delete('ARTICLE_CATEGORIES', array('ID' => $this->input->post('ID')));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function MARK_AS_TODO_DONE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->where('ID', $this->input->post('ID'))->update('TODO', array('DONE' => 'true'));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function UNMARK_AS_TODO_DONE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->where('ID', $this->input->post('ID'))->update('TODO', array('DONE' => 'false'));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function GET_USER($ID)
	{
		$USER = $this->db->get_where('USERS', array('ID' => $ID))->row_array();
		if (isset($USER)) {
			$DATA_USER = array(
				'ID' => $USER['ID'],
				'TOKEN' => $USER['TOKEN'],
				'NAME' => $USER['NAME'],
				'SURNAME' => $USER['SURNAME'],
				'EMAIL' => $USER['EMAIL'],
				'PHONE' => $USER['PHONE'],
			);
			return $DATA_USER;
		} else {
			return null;
		}
	}

	function GET_USER_BY_TOKEN($TOKEN)
	{
		$USER = $this->db->get_where('USERS', array('TOKEN' => $TOKEN))->row_array();
		if ($USER) {
			$DATA_USER = array(
				'ID' => $USER['ID'],
				'TOKEN' => $USER['TOKEN'],
				'NAME' => $USER['NAME'],
				'SURNAME' => $USER['SURNAME'],
				'EMAIL' => $USER['EMAIL'],
				'PHONE' => $USER['PHONE'],
			);
			return $DATA_USER;
		} else {
			return null;
		}
	}

	function GET_ALL_CLIENTS()
	{
		$this->db->select('*');
		$this->db->where('(`ADMIN` = "false" AND `STAFF` = "false")');
		$this->db->order_by('USERS.ID', 'asc');
		$RECORDS = $this->db->get('USERS')->result_array();
		echo json_encode($RECORDS);
	}

	function GET_CLIENTS()
	{
		$POST_DATA = file_get_contents("php://input");
		$COMING_DATA['REQUEST'] = json_decode($POST_DATA);
		$NAME = $COMING_DATA['REQUEST']->FILTER->{'NAME'};
		$COMING_DATA['REQUEST']->OFFSET = $COMING_DATA['REQUEST']->OFFSET - 1;
		if ($COMING_DATA['REQUEST']->OFFSET < 0) {
			$COMING_DATA['REQUEST']->OFFSET = 0;
		}
		$FROM = $COMING_DATA['REQUEST']->OFFSET * $COMING_DATA['REQUEST']->LIMIT;
		$RESPONSE = array();
		## Total number of RECORDS without filtering
		$this->db->select('count(*) as allcount');
		$this->db->where('CLIENT_ID is NULL', NULL, FALSE);
		$this->db->where('(`ADMIN` = "false" AND `STAFF` = "false")');
		$RECORDS = $this->db->get('USERS')->result();
		// Total Records Filters
		$TOTAL_RECORDS = $RECORDS[0]->allcount;
		$this->db->where('CLIENT_ID is NULL', NULL, FALSE);
		$this->db->where('(`ADMIN` = "false" AND `STAFF` = "false")');
		if ($NAME != '') {
			$this->db->like('USERS.NAME', $NAME);
			$this->db->or_like('USERS.SURNAME', $NAME);
		}
		// Total Records Filters
		## Total number of record with filtering
		$this->db->select('count(*) as allcount');
		$RECORDS = $this->db->get('USERS')->result();
		$TOTAL_RECORD_WITH_FILTER = $RECORDS[0]->allcount;
		## Fetch RECORDS
		$this->db->select('*');
		$this->db->where('CLIENT_ID is NULL', NULL, FALSE);
		$this->db->where('(`ADMIN` = "false" AND `STAFF` = "false")');
		$this->db->order_by('USERS.ID', 'asc');
		$this->db->limit($COMING_DATA['REQUEST']->LIMIT, $FROM);
		//  Records Filters
		if ($NAME != '') {
			$this->db->like('USERS.NAME', $NAME);
			$this->db->or_like('USERS.SURNAME', $NAME);
		}
		//  Records Filters
		$RECORDS = $this->db->get('USERS')->result_array();
		$CLIENT_TICKETS = array();
		foreach ($RECORDS as $CLIENT) {
			if (is_null($CLIENT['CLIENT_ID'])) {
				$CLIENT_TOKEN = $CLIENT['TOKEN'];
			} else {
				$CLIENT_TOKEN = $CLIENT['CLIENT_ID'];
			}
			$DATA_CLIENT[] = array(
				'ID' => str_pad($CLIENT['ID'], 6, '0', STR_PAD_LEFT),
				'TOKEN' => $CLIENT['TOKEN'],
				'EMAIL' => $CLIENT['EMAIL'],
				'NAME' => $CLIENT['NAME'],
				'SURNAME' => $CLIENT['SURNAME'],
				'TOTAL_TICKET_COUNTS' => $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT_TOKEN, 'STATUS'))->num_rows(),
				'OPEN_TICKET_COUNTS' => $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT_TOKEN, 'STATUS', 'STATUS' => 1))->num_rows(),
				'IN_PROGRESS_TICKET_COUNTS' => $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT_TOKEN, 'STATUS', 'STATUS' => 2))->num_rows(),
				'REPLIED_TICKET_COUNTS' => $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT_TOKEN, 'STATUS', 'STATUS' => 3))->num_rows(),
				'CLOSED_TICKET_COUNTS' => $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT_TOKEN, 'STATUS', 'STATUS' => 4))->num_rows(),
			);
		};
		$RESPONSE = array(
			"ALL_TOTAL" => $TOTAL_RECORDS,
			"TOTAL" => $TOTAL_RECORD_WITH_FILTER,
			"CLIENTS" => $DATA_CLIENT
		);

		echo json_encode($RESPONSE);
	}

	function GET_CLIENT($TOKEN)
	{
		$CLIENT = $this->db->get_where('USERS', array('TOKEN' => $TOKEN))->row_array();
		if (is_null($CLIENT['CLIENT_ID'])) {
			$CLIENT_ID = $CLIENT['TOKEN'];
		} else {
			$CLIENT_ID = $CLIENT['CLIENT_ID'];
		}
		$TICKETS = $this->db->get_where('TICKETS', array('CLIENT' => $CLIENT_ID))->result_array();
		$DATA_RESULT = array();
		foreach ($TICKETS as $TICKET) {
			$USER = $this->GET_USER($TICKET['USER_ID']);
			$SEEN_BY = $this->GET_USER($TICKET['SEEN_BY']);
			$ASSIGNED = $this->GET_USER($TICKET['ASSIGNED_ID']);
			$CLOSER = $this->GET_USER($TICKET['CLOSER_ID']);
			if ($ASSIGNED) {
				$ASSIGNED_FLAG = $ASSIGNED;
			} else {
				$ASSIGNED_FLAG = false;
			}
			$CATEGORY = $this->db->get_where('CATEGORIES', array('ID' => $TICKET['CATEGORY_ID']))->row_array();
			$DEPARTMENT = $this->db->get_where('DEPARTMENTS', array('ID' => $TICKET['DEPARTMENT_ID']))->row_array();
			switch ($TICKET['STATUS']) {
				case '1':
					$STATUS =  GET_PHRASE('Opened');
					break;
				case '2':
					$STATUS =  GET_PHRASE('Assigned');
					break;
				case '3':
					$STATUS =  GET_PHRASE('Replied');
					break;
				case '4':
					$STATUS =  GET_PHRASE('Closed');
					break;
			};
			$DATA_RESULT[] = array(
				'ID' => $TICKET['ID'],
				'TOKEN' => $TICKET['TOKEN'],
				'CREATED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CREATED_DATE'])),
				'USER' => $USER,
				'SEEN_BY' => $SEEN_BY,
				'SEEN_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['SEEN_DATE'])),
				'ASSIGNED' => $ASSIGNED_FLAG,
				'ASSIGNED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['ASSIGNED_DATE'])),
				'CLOSER' => $CLOSER,
				'CLOSED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CLOSED_DATE'])),
				'SUBJECT' => $TICKET['SUBJECT'],
				'DETAIL' => $TICKET['DETAIL'],
				'PRIORITY' => $TICKET['PRIORITY'],
				'PROCESS' => $TICKET['PROCESS'],
				'STATUS' => $TICKET['STATUS'],
				'STATUS_NAME' => $STATUS,
				'CATEGORY' => $CATEGORY,
				'CATEGORY_ID' => $TICKET['CATEGORY_ID'],
				'DEPARTMENT' => $DEPARTMENT,
				'DEPARTMENT_ID' => $TICKET['DEPARTMENT_ID'],
			);
		};
		if (is_null($CLIENT['CLIENT_ID'])) {
			$CLIENT_STAFF = $this->db->get_where('USERS', array('CLIENT_ID' => $TOKEN))->result_array();
		} else {
			$CLIENT_STAFF = $this->db->get_where('USERS', array('TOKEN' => $CLIENT['CLIENT_ID']))->result_array();
		}
		$DATA_STAFF = array();
		foreach ($CLIENT_STAFF as $USER) {
			switch ($USER['ADMIN']) {
				case 'true':
					$ADMIN = true;
					break;
				case 'false':
					$ADMIN = false;
					break;
			}
			switch ($USER['STAFF']) {
				case 'true':
					$STAFF = true;
					break;
				case 'false':
					$STAFF = false;
					break;
			}
			$DATA_STAFF[] = array(
				'ID' => $USER['ID'],
				'CLIENT_ID' => $USER['CLIENT_ID'],
				'LANGUAGE' => $USER['LANGUAGE'],
				'ADDRESS' => $USER['ADDRESS'],
				'PHONE' => $USER['PHONE'],
				'TOKEN' => $USER['TOKEN'],
				'EMAIL' => $USER['EMAIL'],
				'NAME' => $USER['NAME'],
				'SURNAME' => $USER['SURNAME'],
			);
		};
		$DATA_CLIENT = array(
			'ID' => $CLIENT['ID'],
			'TOKEN' => $CLIENT['TOKEN'],
			'NAME' => $CLIENT['NAME'],
			'SURNAME' => $CLIENT['SURNAME'],
			'EMAIL' => $CLIENT['EMAIL'],
			'PHONE' => $CLIENT['PHONE'],
			'ADDRESS' => $CLIENT['ADDRESS'],
			'ADDITIONAL_DATA' => $CLIENT['ADDITIONAL_DATA'],
			'STAFF' => $DATA_STAFF,
			'TICKETS' => $DATA_RESULT,
		);
		echo json_encode($DATA_CLIENT);
	}

	function CREATE_TICKET()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$TOKEN = CREATE_TOKEN(date('Y-m-d H:i:s'));
			if (is_null($_SESSION['CLIENT_ID'])) {
				$CLIENT = $_SESSION['TOKEN'];
			} else {
				$CLIENT = $_SESSION['CLIENT_ID'];
			}
			$TICKET_DETAILS = array(
				'TOKEN' => $TOKEN,
				'CREATED_DATE' => date('Y-m-d H:i:s'),
				'SUBJECT' => $this->input->post('SUBJECT'),
				'DETAIL' => $this->input->post('DETAIL'),
				'CLIENT' => $CLIENT,
				'PRIORITY' => $this->input->post('PRIORITY'),
				'DEPARTMENT_ID' => $this->input->post('DEPARTMENT_ID'),
				'CATEGORY_ID' => 1,
				'STATUS' => 1,
				'USER_ID' => $_SESSION['USER_ID'],
				'SUBJECT' => $this->input->post('SUBJECT'),
			);
			$PROCESS = $this->db->order_by("ORDER", "asc")->get_where('PROCESSES', array('DEPARTMENT_ID' => $this->input->post('DEPARTMENT_ID')))->row_array();
			if (isset($PROCESS)) {
				$TICKET_DETAILS['PROCESS'] = $PROCESS['ID'];
			}
			if (is_null($_SESSION['CLIENT_ID'])) {
				$SLA_TRIGGER_RELATION = $this->GET_USER_BY_TOKEN($_SESSION['TOKEN']);
			} else {
				$SLA_TRIGGER_RELATION = $this->GET_USER_BY_TOKEN($_SESSION['CLIENT_ID']);
			}
			$SLA = $this->CHECK_SLA_FOR_TICKET(1, $SLA_TRIGGER_RELATION['ID']);
			if (isset($SLA)) {
				$TICKET_DETAILS['SLA_POLICY']  = $SLA['ID'];
			}
			$this->db->insert('TICKETS', $TICKET_DETAILS);
			$TICKET_ID = $this->db->insert_id();
			$CUSTOM_FIELDS = json_decode($this->input->post('CUSTOM_FIELDS'), true);
			if ($CUSTOM_FIELDS) {
				$i = 0;
				foreach ($CUSTOM_FIELDS as $FIELD) {
					$this->db->insert('CUSTOM_FIELD_DATA', array(
						'FIELD_ID' => $FIELD['ID'],
						'RELATED_ID' => 	$TICKET_ID,
						'DATA' => json_encode($FIELD['DATA']),
					));
					$i++;
				};
			}

			if ($this->input->post('ATTACHMENT')) {
				$ATTACHMENTS = $this->input->post('ATTACHMENT');
				$i = 0;
				foreach ($ATTACHMENTS as $ATTACHMENT) {
					$ATTACHMENT_PARAMS = array(
						'UPLOAD_DATE' => date('Y-m-d H:i:s'),
						'FILE_NAME' => $ATTACHMENT['FILE_NAME'],
						'FILE_TYPE' => $ATTACHMENT['FILE_TYPE'],
						'FILE_SIZE' => $ATTACHMENT['FILE_SIZE'],
						'RELATION_TYPE' => 'TICKET',
						'RELATED_ID' => $TICKET_ID,
						'UPLOADER_ID' => $_SESSION['USER_ID'],
					);
					$this->db->insert('FILES', $ATTACHMENT_PARAMS);
					$i++;
				};
			}
			$SESSIONED_USER = $this->GET_USER($_SESSION['USER_ID']);
			$TICKET = $this->db->get_where('TICKETS', array('ID' => $TICKET_ID))->row_array();
			$this->db->insert('LOGS', array('USER_ID' => $_SESSION['USER_ID'], 'CLIENT' => $CLIENT, 'RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET_ID, 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_CREATE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'])));
			echo $TOKEN;
		} else {
			echo json_encode(false);
		}
	}

	function CHECK_SLA_FOR_TICKET($RELATION_TYPE, $RELATION)
	{
		$this->db->select('*');
		$this->db->from('SLA_POLICIES');
		$this->db->where('JSON_EXTRACT(SLA_POLICIES.TRIGGER, "$.RELATION_TYPE") = "' . $RELATION_TYPE . '"');
		$this->db->where('JSON_EXTRACT(SLA_POLICIES.TRIGGER, "$.RELATION") = "' . $RELATION . '"');
		$SLA_POLICY = $this->db->get()->row_array();
		return $SLA_POLICY;
	}

	function REMOVE_TICKET()
	{
		if (isset($_POST)) {
			if ($_SESSION["ADMIN"] == 'true' || $_SESSION["STAFF"] == 'true') {
				$ATTACHMENTS = $this->db->get_where('FILES', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $this->input->post('ID')))->result_array();
				if (isset($ATTACHMENTS)) {
					foreach ($ATTACHMENTS as $KEY) {
						$FILE = APPPATH . '../assets/uploads/ticket-attachments/' . $KEY['FILE_NAME'] . '';
						unlink($FILE);
					}
				}
				$CONVERSATIONS = $this->db->get_where('CONVERSATIONS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $this->input->post('ID')))->result_array();
				if (isset($CONVERSATIONS)) {
					foreach ($CONVERSATIONS as $CONV) {
						$CNV_ATTACHMENTS = $this->db->get_where('FILES', array('RELATION_TYPE' => 'CONVERSATION', 'RELATED_ID' => $CONV['ID']))->result_array();
						if (isset($CNV_ATTACHMENTS)) {
							foreach ($CNV_ATTACHMENTS as $KEY) {
								$FILE = APPPATH . '../assets/uploads/ticket-attachments/' . $KEY['FILE_NAME'] . '';
								unlink($FILE);
							}
						}
					}
				}

				$this->db->delete('SLA_VIOLATIONS', array('TICKET_ID' => $this->input->post('ID')));
				$this->db->delete('CONVERSATIONS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $this->input->post('ID')));
				$this->db->delete('NOTES', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $this->input->post('ID')));
				$this->db->delete('FILES', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $this->input->post('ID')));
				$this->db->delete('LOGS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $this->input->post('ID')));
				$this->db->delete('NOTIFICATIONS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $this->input->post('ID')));
				$this->db->delete('TICKETS', array('ID' => $this->input->post('ID')));
				echo json_encode(true);
			} else {
				echo json_encode(false);
			}
		}
	}

	function REMOVE_REPLY()
	{
		if (isset($_POST) && count($_POST) > 0) {
			if ($_SESSION['STAFF'] == 'true' ||  $_SESSION['ADMIN'] == 'true') {
				$this->db->delete('CONVERSATIONS', array('ID' => $this->input->post('ID')));
				echo json_encode(true);
			} else {
				$REPLY = $this->db->get_where('CONVERSATIONS', array('ID' => $this->input->post('ID')))->row_array();
				if ($REPLY['SENDER_ID'] == $_SESSION['USER_ID']) {
					$this->db->delete('CONVERSATIONS', array('ID' => $this->input->post('ID')));
					echo json_encode(true);
				} else {
					echo json_encode(false);
				}
			}
		} else {
			echo json_encode(false);
		}
	}

	function REMOVE_NOTE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			if ($_SESSION['STAFF'] == 'true' ||  $_SESSION['ADMIN'] == 'true') {
				$this->db->delete('NOTES', array('ID' => $this->input->post('ID')));
				echo json_encode(true);
			} else {
				echo json_encode(false);
			}
		} else {
			echo json_encode(false);
		}
	}

	function GET_TICKETS()
	{
		$POST_DATA = file_get_contents("php://input");
		$COMING_DATA['REQUEST'] = json_decode($POST_DATA);
		$KEYWORD = $COMING_DATA['REQUEST']->FILTER->{'KEYWORD'};
		$ASSIGNATED = $COMING_DATA['REQUEST']->FILTER->{'ASSIGNATED'};
		$STATUS_FILTER = $COMING_DATA['REQUEST']->FILTER->{'STATUS'};
		$PRIORITY_FILTER = $COMING_DATA['REQUEST']->FILTER->{'PRIORITY'};
		$CATEGORY_FILTER = $COMING_DATA['REQUEST']->FILTER->{'CATEGORY'};
		$DEPARTMENT_FILTER = $COMING_DATA['REQUEST']->FILTER->{'DEPARTMENT'};
		$CREATED_DATE_START = $COMING_DATA['REQUEST']->FILTER->{'CREATED_DATE_START'};
		$CREATED_DATE_END = $COMING_DATA['REQUEST']->FILTER->{'CREATED_DATE_END'};
		$ORDER_BY_CLIENT = $COMING_DATA['REQUEST']->FILTER->{'ORDER_BY_CLIENT'};
		$ORDER_BY_ID = $COMING_DATA['REQUEST']->FILTER->{'ORDER_BY_ID'};
		$ORDER_BY_DATE = $COMING_DATA['REQUEST']->FILTER->{'ORDER_BY_DATE'};
		$ORDER_BY_ASSIGNED = $COMING_DATA['REQUEST']->FILTER->{'ORDER_BY_ASSIGNED'};
		$ORDER_BY_STATUS = $COMING_DATA['REQUEST']->FILTER->{'ORDER_BY_STATUS'};
		$COMING_DATA['REQUEST']->OFFSET = $COMING_DATA['REQUEST']->OFFSET - 1;
		if ($COMING_DATA['REQUEST']->OFFSET < 0) {
			$COMING_DATA['REQUEST']->OFFSET = 0;
		}
		$FROM = $COMING_DATA['REQUEST']->OFFSET * $COMING_DATA['REQUEST']->LIMIT;
		$RESPONSE = array();
		## Total number of RECORDS without filtering
		$this->db->select('count(*) as allcount');
		if ($_SESSION["ADMIN"] == 'false' && $_SESSION["STAFF"] == 'false') {
			if (is_null($_SESSION['CLIENT_ID'])) {
				$CLIENT = $_SESSION['TOKEN'];
			} else {
				$CLIENT = $_SESSION['CLIENT_ID'];
			}
			$this->db->where('TICKETS.CLIENT', $CLIENT);
		}
		$this->db->where('PARENT_ID', null);
		$RECORDS = $this->db->get('TICKETS')->result();
		// Total Records Filters
		$TOTAL_RECORDS = $RECORDS[0]->allcount;
		if ($_SESSION["ADMIN"] == 'false' && $_SESSION["STAFF"] == 'false') {
			if (is_null($_SESSION['CLIENT_ID'])) {
				$CLIENT = $_SESSION['TOKEN'];
			} else {
				$CLIENT = $_SESSION['CLIENT_ID'];
			}
			$this->db->where('TICKETS.CLIENT', $CLIENT);
		}
		if ($KEYWORD != '') {
			$this->db->like('TICKETS.SUBJECT', $KEYWORD);
			$this->db->or_like('TICKETS.TOKEN', $KEYWORD);
		}
		if ($ASSIGNATED != false) {
			switch ($ASSIGNATED) {
				case 1:
					$this->db->where('ASSIGNED_ID', null);
					break;
				case 2:
					$this->db->where('ASSIGNED_ID', $_SESSION['USER_ID']);
					break;
			}
		}
		if ($STATUS_FILTER != false) {
			$this->db->where_in('TICKETS.STATUS', $STATUS_FILTER);
		}
		if ($PRIORITY_FILTER != false) {
			$this->db->where_in('TICKETS.PRIORITY', $PRIORITY_FILTER);
		}
		if ($CATEGORY_FILTER != false) {
			$this->db->where_in('TICKETS.CATEGORY_ID', $CATEGORY_FILTER);
		}
		if ($DEPARTMENT_FILTER != false) {
			$this->db->where_in('TICKETS.DEPARTMENT_ID', $DEPARTMENT_FILTER);
		}
		if ($CREATED_DATE_START != 'Invalid date' && $CREATED_DATE_END != 'Invalid date') {
			$this->db->where('(created_date BETWEEN "' . $CREATED_DATE_START . '" AND "' . $CREATED_DATE_END . '")');
		}
		// Total Records Filters
		## Total number of record with filtering
		$this->db->select('count(*) as allcount');
		$this->db->where('PARENT_ID', null);
		$RECORDS = $this->db->get('TICKETS')->result();
		$TOTAL_RECORD_WITH_FILTER = $RECORDS[0]->allcount;
		## Fetch RECORDS
		$this->db->select('*');
		if ($_SESSION["ADMIN"] == 'false' && $_SESSION["STAFF"] == 'false') {
			if (is_null($_SESSION['CLIENT_ID'])) {
				$CLIENT = $_SESSION['TOKEN'];
			} else {
				$CLIENT = $_SESSION['CLIENT_ID'];
			}
			$this->db->where('TICKETS.CLIENT', $CLIENT);
		}
		// ORDER BY FUNCTIONS
		if ($ORDER_BY_CLIENT != false) {
			$this->db->order_by('TICKETS.USER_ID', 'asc');
		}
		if ($ORDER_BY_ID != false) {
			$this->db->order_by('TICKETS.ID', 'asc');
		}
		if ($ORDER_BY_DATE != false) {
			$this->db->order_by('TICKETS.CREATED_DATE', 'asc');
		}
		if ($ORDER_BY_ASSIGNED != false) {
			$this->db->order_by('TICKETS.ASSIGNED_ID', 'asc');
		}
		if ($ORDER_BY_STATUS != false) {
			$this->db->order_by('TICKETS.STATUS', 'asc');
		}
		// ORDER BY FUNCTIONS
		$this->db->order_by('TICKETS.ID', 'desc');
		$this->db->limit($COMING_DATA['REQUEST']->LIMIT, $FROM);
		//  Records Filters
		if ($KEYWORD != '') {
			$this->db->like('TICKETS.SUBJECT', $KEYWORD);
			$this->db->or_like('TICKETS.TOKEN', $KEYWORD);
		}
		if ($ASSIGNATED != false) {
			switch ($ASSIGNATED) {
				case 1:
					$this->db->where('ASSIGNED_ID', null);
					break;
				case 2:
					$this->db->where('ASSIGNED_ID', $_SESSION['USER_ID']);
					break;
			}
		}
		if ($STATUS_FILTER != false) {
			$this->db->where_in('TICKETS.STATUS', $STATUS_FILTER);
		}
		if ($PRIORITY_FILTER != false) {
			$this->db->where_in('TICKETS.PRIORITY', $PRIORITY_FILTER);
		}
		if ($CATEGORY_FILTER != false) {
			$this->db->where_in('TICKETS.CATEGORY_ID', $CATEGORY_FILTER);
		}
		if ($DEPARTMENT_FILTER != false) {
			$this->db->where_in('TICKETS.DEPARTMENT_ID', $DEPARTMENT_FILTER);
		}
		if ($CREATED_DATE_START != 'Invalid date' && $CREATED_DATE_END != 'Invalid date') {
			$this->db->where('(CREATED_DATE BETWEEN "' . $CREATED_DATE_START . '" AND "' . $CREATED_DATE_END . '")');
		}
		//  Records Filters
		$this->db->where('PARENT_ID', null);
		$RECORDS = $this->db->get('TICKETS')->result_array();
		$DATA_TICKETS = array();
		foreach ($RECORDS as $TICKET) {
			$USER = $this->db->get_where('USERS', array('ID' => $TICKET['USER_ID']))->row_array();
			$SEEN_BY = $this->db->get_where('USERS', array('ID' => $TICKET['SEEN_BY']))->row_array();
			$ASSIGNED = $this->db->get_where('USERS', array('ID' => $TICKET['ASSIGNED_ID']))->row_array();
			if ($ASSIGNED) {
				$ASSIGNED_FLAG = $ASSIGNED;
			} else {
				$ASSIGNED_FLAG = false;
			}
			$CLOSER = $this->db->get_where('USERS', array('ID' => $TICKET['CLOSER_ID']))->row_array();
			$CATEGORY = $this->db->get_where('CATEGORIES', array('ID' => $TICKET['CATEGORY_ID']))->row_array();
			$DEPARTMENT = $this->db->get_where('DEPARTMENTS', array('ID' => $TICKET['DEPARTMENT_ID']))->row_array();
			switch ($TICKET['STATUS']) {
				case '1':
					$STATUS =  GET_PHRASE('Opened');
					break;
				case '2':
					$STATUS =  GET_PHRASE('Assigned');
					break;
				case '3':
					$STATUS =  GET_PHRASE('Replied');
					break;
				case '4':
					$STATUS =  GET_PHRASE('Closed');
					break;
			};
			$DATA_TICKETS[] = array(
				'ID' => $TICKET['ID'],
				'TOKEN' => $TICKET['TOKEN'],
				'CREATED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CREATED_DATE'])),
				'USER' => $USER,
				'SEEN_BY' => $SEEN_BY,
				'SEEN_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['SEEN_DATE'])),
				'ASSIGNED' => $ASSIGNED_FLAG,
				'ASSIGNED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['ASSIGNED_DATE'])),
				'CLOSER' => $CLOSER,
				'CLOSED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CLOSED_DATE'])),
				'SUBJECT' => $TICKET['SUBJECT'],
				'DETAIL' => $TICKET['DETAIL'],
				'PRIORITY' => $TICKET['PRIORITY'],
				'STATUS' => $TICKET['STATUS'],
				'PROCESS' => $TICKET['PROCESS'],
				'STATUS_NAME' => $STATUS,
				'CATEGORY' => $CATEGORY,
				'CATEGORY_ID' => $TICKET['CATEGORY_ID'],
				'DEPARTMENT' => $DEPARTMENT,
				'DEPARTMENT_ID' => $TICKET['DEPARTMENT_ID'],
			);
		};
		$RESPONSE = array(
			"ALL_TOTAL" => $TOTAL_RECORDS,
			"TOTAL" => $TOTAL_RECORD_WITH_FILTER,
			"ENTRIES" => $DATA_TICKETS
		);

		echo json_encode($RESPONSE);
	}

	function GET_CHILD_TICKETS($ID)
	{
		$TICKETS = $this->db->get_where('TICKETS', array('PARENT_ID' => $ID))->result_array();
		$DATA_RESULT = array();
		foreach ($TICKETS as $TICKET) {
			$USER = $this->GET_USER($TICKET['USER_ID']);
			$SEEN_BY = $this->GET_USER($TICKET['SEEN_BY']);
			$ASSIGNED = $this->GET_USER($TICKET['ASSIGNED_ID']);
			$CLOSER = $this->GET_USER($TICKET['CLOSER_ID']);
			if ($ASSIGNED) {
				$ASSIGNED_FLAG = $ASSIGNED;
			} else {
				$ASSIGNED_FLAG = false;
			}
			$CATEGORY = $this->db->get_where('CATEGORIES', array('ID' => $TICKET['CATEGORY_ID']))->row_array();
			$DEPARTMENT = $this->db->get_where('DEPARTMENTS', array('ID' => $TICKET['DEPARTMENT_ID']))->row_array();
			switch ($TICKET['STATUS']) {
				case '1':
					$STATUS =  GET_PHRASE('Opened');
					break;
				case '2':
					$STATUS =  GET_PHRASE('Assigned');
					break;
				case '3':
					$STATUS =  GET_PHRASE('Replied');
					break;
				case '4':
					$STATUS =  GET_PHRASE('Closed');
					break;
			};
			$DATA_RESULT[] = array(
				'ID' => $TICKET['ID'],
				'TOKEN' => $TICKET['TOKEN'],
				'CREATED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CREATED_DATE'])),
				'USER' => $USER,
				'SEEN_BY' => $SEEN_BY,
				'SEEN_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['SEEN_DATE'])),
				'ASSIGNED' => $ASSIGNED_FLAG,
				'ASSIGNED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['ASSIGNED_DATE'])),
				'CLOSER' => $CLOSER,
				'CLOSED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CLOSED_DATE'])),
				'SUBJECT' => $TICKET['SUBJECT'],
				'DETAIL' => $TICKET['DETAIL'],
				'PRIORITY' => $TICKET['PRIORITY'],
				'PROCESS' => $TICKET['PROCESS'],
				'STATUS' => $TICKET['STATUS'],
				'STATUS_NAME' => $STATUS,
				'CATEGORY' => $CATEGORY,
				'CATEGORY_ID' => $TICKET['CATEGORY_ID'],
				'DEPARTMENT' => $DEPARTMENT,
				'DEPARTMENT_ID' => $TICKET['DEPARTMENT_ID'],
			);
		};
		return $DATA_RESULT;
	}


	function GET_TICKET_DETAIL($TOKEN)
	{
		$TICKET = $this->db->get_where('TICKETS', array('TOKEN' => $TOKEN))->row_array();
		$CHILD_TICKETS = $this->GET_CHILD_TICKETS($TICKET['ID']);
		$TICKET_USER = $this->GET_USER($TICKET['USER_ID']);
		$ATTACHMENTS = $this->db->get_where('FILES', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']))->result_array();
		$CONVERSATIONS = $this->db->get_where('CONVERSATIONS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']))->result_array();
		if ($_SESSION['STAFF'] == 'true' ||  $_SESSION['ADMIN'] == 'true') {
			$NOTES = $this->db->get_where('NOTES', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']))->result_array();
			// Mark ticket as seen!
			if (empty($TICKET['SEEN_BY'])) {
				$this->db->where('ID', $TICKET['ID'])->update('TICKETS', array('SEEN_BY' => $_SESSION['USER_ID'], 'SEEN_DATE' => date('Y-m-d H:i:s')));
			}
		} else {
			$NOTES = $this->db->get_where('NOTES', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID'], 'PRIVATE' => 'false'))->result_array();
		}
		$LOGS = $this->db->order_by("ID", "desc")->get_where('LOGS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']))->result_array();
		$SEEN_BY = $this->GET_USER($TICKET['SEEN_BY']);
		$ASSIGNED = $this->GET_USER($TICKET['ASSIGNED_ID']);
		$CLOSER = $this->GET_USER($TICKET['CLOSER_ID']);
		if ($CONVERSATIONS) {
			$DATA_CONVERSATIONS = array();
			foreach ($CONVERSATIONS as $CONVERSATION) {
				$CONVERSATION_USER = $this->GET_USER($CONVERSATION['SENDER_ID']);
				$RECEIVER = $this->GET_USER($CONVERSATION['RECEIVER_ID']);
				$CONVERSATION_ATTACHMENTS = $this->db->get_where('FILES', array('RELATION_TYPE' => 'CONVERSATION', 'RELATED_ID' => $CONVERSATION['ID']))->result_array();
				$DATA_CONVERSATIONS[] = array(
					'ID' => $CONVERSATION['ID'],
					'USER' => $CONVERSATION_USER,
					'RECEIVER' => $RECEIVER,
					'DATE' => date(DATE_ISO8601, strtotime($CONVERSATION['DATE'])),
					'CONTENT' => $CONVERSATION['MESSAGE'],
					'ATTACHMENTS' => $CONVERSATION_ATTACHMENTS,
					'TYPE' => 'CONVERSATION',
				);
			}
		} else {
			$DATA_CONVERSATIONS = null;
		}
		if ($NOTES) {
			$DATA_NOTES = array();
			foreach ($NOTES as $NOTE) {
				$NOTE_USER = $this->GET_USER($NOTE['USER_ID']);
				$NOTE_ATTACHMENTS = $this->db->get_where('FILES', array('RELATION_TYPE' => 'NOTE', 'RELATED_ID' => $NOTE['ID']))->result_array();
				$DATA_NOTES[] = array(
					'ID' => $NOTE['ID'],
					'USER' => $NOTE_USER,
					'DATE' => date(DATE_ISO8601, strtotime($NOTE['DATE'])),
					'CONTENT' => $NOTE['NOTE'],
					'ATTACHMENTS' => $NOTE_ATTACHMENTS,
					'TYPE' => 'NOTE',
					'PRIVATE' => $NOTE['PRIVATE']
				);
			}
		} else {
			$DATA_NOTES = null;
		};
		if ($LOGS) {
			$DATA_LOGS = array();
			foreach ($LOGS as $LOG) {
				$LOG_USER = $this->GET_USER($LOG['USER_ID']);
				$DATA_LOGS[] = array(
					'ID' => $LOG['ID'],
					'USER' => $LOG_USER,
					'DATE' => date(DATE_ISO8601, strtotime($LOG['DATE'])),
					'DETAIL' => $LOG['DETAIL'],
				);
			}
		} else {
			$DATA_LOGS = null;
		}
		if ($DATA_CONVERSATIONS && $DATA_NOTES) {
			$REPLIES = array_merge($DATA_CONVERSATIONS, $DATA_NOTES);
		} else if ($DATA_CONVERSATIONS && !$DATA_NOTES) {
			$REPLIES = $DATA_CONVERSATIONS;
		} else if (!$DATA_CONVERSATIONS && $DATA_NOTES) {
			$REPLIES = $DATA_NOTES;
		} else if (!$DATA_CONVERSATIONS && !$DATA_NOTES) {
			$REPLIES = null;
		}

		$CUSTOM_FIELDS_DATA = $this->db->get_where('CUSTOM_FIELD_DATA', array('RELATED_ID' => $TICKET['ID']))->result_array();
		$DATA_CUSTOM_FIELDS = array();
		foreach ($CUSTOM_FIELDS_DATA as $FIELD_DATA) {
			$FIELD = $this->db->get_where('CUSTOM_FIELDS', array('ID' => $FIELD_DATA['FIELD_ID']))->row_array();
			if ($FIELD) {
				if ($FIELD['PERMISSIONS'] && $_SESSION['STAFF'] == 'true') {
					continue;
				}
				if ($FIELD_DATA['DATA']) {
					switch ($FIELD['TYPE']) {
						case 'input':
							$LEFT_DATA = json_decode($FIELD_DATA['DATA'], true);
							$SELECT_OPTIONS = 0;
							break;
						case 'date':
							$LEFT_DATA = date(DATE_ISO8601, strtotime($FIELD_DATA['DATA']));
							$SELECT_OPTIONS = 0;
							break;
						case 'number':
							$LEFT_DATA = $FIELD_DATA['DATA'];
							$SELECT_OPTIONS = 0;
							break;
						case 'textarea':
							$LEFT_DATA = $FIELD_DATA['DATA'];
							$SELECT_OPTIONS = 0;
							break;
						case 'select':
							$CLEAR_DATA = json_decode($FIELD_DATA['DATA']);
							$LEFT_DATA = $CLEAR_DATA[0];
							$SELECT_OPTIONS = json_decode($FIELD['DATA']);
							break;
						case 'radio':
							$LEFT_DATA = json_decode($FIELD_DATA['DATA']);
							$SELECT_OPTIONS = json_decode($FIELD['DATA']);
							break;
					}
				} else {
					$LEFT_DATA = $FIELD['DATA'];
					$SELECT_OPTIONS = null;
				}
				$DATA_CUSTOM_FIELDS[] = array(
					'ID' => $FIELD['ID'],
					'NAME' => $FIELD['NAME'],
					'TYPE' => $FIELD['TYPE'],
					'REQUIRED' => $FIELD['REQUIRED'],
					'DESCRIPTION' => $FIELD['DESCRIPTION'],
					'ORDER' => $FIELD['ORDER'],
					'DATA' => $LEFT_DATA,
					'SELECT_OPTIONS' => $SELECT_OPTIONS,
					'RELATION_TYPE' => $FIELD['RELATION_TYPE'],
					'CONDITION' =>  json_decode($FIELD['CONDITION'], true),
					'APPLICANT_TYPE' => $FIELD['APPLICANT_TYPE'],
					'ACTIVE' => $FIELD['ACTIVE'] === 'true' ? true : false,
				);
			}
		}

		$DATA_TICKET = array(
			'ID' => $TICKET['ID'],
			'TOKEN' => $TICKET['TOKEN'],
			'CREATED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CREATED_DATE'])),
			'USER' => $TICKET_USER,
			'SEEN_BY' => $SEEN_BY,
			'SEEN_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['SEEN_DATE'])),
			'ASSIGNED' => $ASSIGNED,
			'ASSIGNED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['ASSIGNED_DATE'])),
			'CLOSER' => $CLOSER,
			'CLOSED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CLOSED_DATE'])),
			'SUBJECT' => $TICKET['SUBJECT'],
			'DETAIL' => $TICKET['DETAIL'],
			'CLIENT' => $TICKET['CLIENT'],
			'PRIORITY' => $TICKET['PRIORITY'],
			'STATUS' => $TICKET['STATUS'],
			'PROCESS' => $TICKET['PROCESS'],
			'SLA' => GET_SLA_POLICY($TICKET['ID']),
			'SLA_POLICY' => $TICKET['SLA_POLICY'],
			'CATEGORY_ID' => $TICKET['CATEGORY_ID'],
			'DEPARTMENT_ID' => $TICKET['DEPARTMENT_ID'],
			'ATTACHMENTS' => $ATTACHMENTS,
			'CONVERSATIONS' => $DATA_CONVERSATIONS,
			'CUSTOM_FIELDS' => $DATA_CUSTOM_FIELDS,
			'NOTES' => $NOTES,
			'CHILD_TICKETS' => $CHILD_TICKETS,
			'PARENT' =>  $this->db->get_where('TICKETS', array('ID' => $TICKET['PARENT_ID']))->row_array(),
			'LOGS' => $DATA_LOGS,
			'REPLIES' => $REPLIES,
			'SPAM' => $TICKET['SPAM'] === 'true' ? true : false,
		);
		echo json_encode($DATA_TICKET);
	}

	function SEARCH_TICKET_FOR_MERGE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			if (strlen(trim($_POST['KEY'])) > 4) {
				if ($_POST['KEY'] != '') {
					$KEY = str_replace(array("#", "'", ";"), '', $_POST['KEY']);
					$this->db->like('TOKEN', $KEY);
					$QUERY = $this->db->get('TICKETS');
					$RESULT =  $QUERY->row();
					if ($RESULT) {
						echo json_encode($RESULT);
					} else {
						echo null;
					}
				} else {
					echo null;
				}
			} else {
				echo null;
			}
		}
	}

	function GET_ALL_STAFF()
	{
		if ($_SESSION['STAFF'] == 'true' ||  $_SESSION['ADMIN'] == 'true') {
			$this->db->from('USERS');
			$this->db->where('(STAFF = "true" or ADMIN = "true" )');
			$query = $this->db->get();
			$ALL_STAFF = $query->result_array();
			$PERMISSIONS = GET_ALL_PERMISSIONS();
			$PRIVILEGES = GET_PRIVILEGES();
			$DATA_USERS = array();
			foreach ($ALL_STAFF as $USER) {
				switch ($USER['ADMIN']) {
					case 'true':
						$ADMIN = true;
						break;
					case 'false':
						$ADMIN = false;
						break;
				}
				switch ($USER['STAFF']) {
					case 'true':
						$STAFF = true;
						break;
					case 'false':
						$STAFF = false;
						break;
				}
				$DATA_USERS[] = array(
					'ID' => $USER['ID'],
					'CLIENT_ID' => $USER['CLIENT_ID'],
					'DEPARTMENT_ID' => $USER['DEPARTMENT_ID'],
					'LANGUAGE' => $USER['LANGUAGE'],
					'ADDRESS' => $USER['ADDRESS'],
					'PHONE' => $USER['PHONE'],
					'TOKEN' => $USER['TOKEN'],
					'EMAIL' => $USER['EMAIL'],
					'NAME' => $USER['NAME'],
					'SURNAME' => $USER['SURNAME'],
					'USERNAME' => $USER['USERNAME'],
					//'JOIN_DATE' => date(DATE_ISO8601, strtotime($USER['JOIN_DATE'])),
					'ADMIN' => $ADMIN,
					'STAFF' => $STAFF,
				);
			};
			echo json_encode($DATA_USERS);
		} else {
			if (is_null($_SESSION['CLIENT_ID'])) {
				$CLIENT = $_SESSION['TOKEN'];
			} else {
				$CLIENT = $_SESSION['CLIENT_ID'];
			}
			$ALL_STAFF = $this->db->get_where('USERS', array('CLIENT_ID' => $CLIENT))->result_array();
			$PERMISSIONS = GET_ALL_PERMISSIONS();
			$PRIVILEGES = GET_PRIVILEGES();
			$DATA_USERS = array();
			foreach ($ALL_STAFF as $USER) {
				switch ($USER['ADMIN']) {
					case 'true':
						$ADMIN = true;
						break;
					case 'false':
						$ADMIN = false;
						break;
				}
				switch ($USER['STAFF']) {
					case 'true':
						$STAFF = true;
						break;
					case 'false':
						$STAFF = false;
						break;
				}
				$DATA_USERS[] = array(
					'ID' => $USER['ID'],
					'CLIENT_ID' => $USER['CLIENT_ID'],
					'DEPARTMENT_ID' => $USER['DEPARTMENT_ID'],
					'LANGUAGE' => $USER['LANGUAGE'],
					'ADDRESS' => $USER['ADDRESS'],
					'PHONE' => $USER['PHONE'],
					'TOKEN' => $USER['TOKEN'],
					'EMAIL' => $USER['EMAIL'],
					'NAME' => $USER['NAME'],
					'SURNAME' => $USER['SURNAME'],
					'USERNAME' => $USER['USERNAME'],
					//'JOIN_DATE' => date(DATE_ISO8601, strtotime($USER['JOIN_DATE'])),
					'ADMIN' => $ADMIN,
					'STAFF' => $STAFF,
				);
			};
			echo json_encode($DATA_USERS);
		}
	}

	function GET_STAFF($TOKEN)
	{

		if (is_null($_SESSION['CLIENT_ID'])) {
			$CLIENT = $_SESSION['TOKEN'];
		} else {
			$CLIENT = $_SESSION['CLIENT_ID'];
		}
		$USER = $this->db->get_where('USERS', array('TOKEN' => $TOKEN))->row_array();
		$PERMISSIONS = GET_ALL_PERMISSIONS();
		$PRIVILEGES = GET_PRIVILEGES();
		$arr = array();
		foreach ($PRIVILEGES as $PERMISSION) {
			if ($PERMISSION['USER_ID'] == $USER['ID']) {
				array_push($arr, $PERMISSION['PERMISSION_ID']);
			}
		}
		$data_PRIVILEGES = array();
		foreach ($PERMISSIONS as $PERMISSION) {
			$data_PRIVILEGES[] = array(
				'ID' => $PERMISSION['ID'],
				'NAME' => GET_PHRASE($PERMISSION['KEY']),
				'VALUE' => '' . (array_search($PERMISSION['ID'], $arr) !== FALSE) ? true : false . ''
			);
		}
		switch ($USER['ADMIN']) {
			case 'true':
				$ADMIN = true;
				break;
			case 'false':
				$ADMIN = false;
				break;
		}
		switch ($USER['STAFF']) {
			case 'true':
				$STAFF = true;
				break;
			case 'false':
				$STAFF = false;
				break;
		}
		switch ($USER['ACTIVE']) {
			case 'true':
				$ACTIVE = true;
				break;
			case 'false':
				$ACTIVE = false;
				break;
		}
		$WORKING_HOURS = $this->db->select('*')->get_where('WORKING_HOURS', array('USER_ID' => $USER['ID']))->row_array();
		if ($WORKING_HOURS) {
			$WORKING_HOURS_DATA = json_decode($WORKING_HOURS['WORKING_HOURS'], true);
		} else {
			$WORKING_HOURS_DATA = null;
		};
		$TICKETS = $this->db->get_where('TICKETS', array('ASSIGNED_ID' => $USER['ID']))->result_array();
		$TICKETS_DATA = array();
		foreach ($TICKETS as $TICKET) {
			$TICKET_USER = $this->GET_USER($TICKET['USER_ID']);
			$SEEN_BY = $this->GET_USER($TICKET['SEEN_BY']);
			$ASSIGNED = $this->GET_USER($TICKET['ASSIGNED_ID']);
			$CLOSER = $this->GET_USER($TICKET['CLOSER_ID']);
			if ($ASSIGNED) {
				$ASSIGNED_FLAG = $ASSIGNED;
			} else {
				$ASSIGNED_FLAG = false;
			}
			$CATEGORY = $this->db->get_where('CATEGORIES', array('ID' => $TICKET['CATEGORY_ID']))->row_array();
			$DEPARTMENT = $this->db->get_where('DEPARTMENTS', array('ID' => $TICKET['DEPARTMENT_ID']))->row_array();
			switch ($TICKET['STATUS']) {
				case '1':
					$STATUS =  GET_PHRASE('Opened');
					break;
				case '2':
					$STATUS =  GET_PHRASE('Assigned');
					break;
				case '3':
					$STATUS =  GET_PHRASE('Replied');
					break;
				case '4':
					$STATUS =  GET_PHRASE('Closed');
					break;
			};
			$TICKETS_DATA[] = array(
				'ID' => $TICKET['ID'],
				'TOKEN' => $TICKET['TOKEN'],
				'CREATED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CREATED_DATE'])),
				'USER' => $TICKET_USER,
				'SEEN_BY' => $SEEN_BY,
				'SEEN_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['SEEN_DATE'])),
				'ASSIGNED' => $ASSIGNED_FLAG,
				'ASSIGNED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['ASSIGNED_DATE'])),
				'CLOSER' => $CLOSER,
				'CLOSED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CLOSED_DATE'])),
				'SUBJECT' => $TICKET['SUBJECT'],
				'DETAIL' => $TICKET['DETAIL'],
				'PRIORITY' => $TICKET['PRIORITY'],
				'PROCESS' => $TICKET['PROCESS'],
				'STATUS' => $TICKET['STATUS'],
				'STATUS_NAME' => $STATUS,
				'CATEGORY' => $CATEGORY,
				'CATEGORY_ID' => $TICKET['CATEGORY_ID'],
				'DEPARTMENT' => $DEPARTMENT,
				'DEPARTMENT_ID' => $TICKET['DEPARTMENT_ID'],
			);
		};
		$LOGS = $this->db->limit(100)->order_by("ID", "desc")->get_where('LOGS', array('RELATION_TYPE' => 'TICKET', 'USER_ID' => $USER['ID']))->result_array();
		if ($LOGS) {
			$DATA_LOGS = array();
			foreach ($LOGS as $LOG) {
				$LOG_USER = $this->GET_USER($LOG['USER_ID']);
				$DATA_LOGS[] = array(
					'ID' => $LOG['ID'],
					'USER' => $LOG_USER,
					'DATE' => date(DATE_ISO8601, strtotime($LOG['DATE'])),
					'DETAIL' => $LOG['DETAIL'],
				);
			}
		} else {
			$DATA_LOGS = null;
		}
		$DATA_USER = array(
			'ID' => $USER['ID'],
			'CLIENT_ID' => $USER['CLIENT_ID'],
			'DEPARTMENT_ID' => $USER['DEPARTMENT_ID'],
			'LANGUAGE' => $USER['LANGUAGE'],
			'ADDRESS' => $USER['ADDRESS'],
			'PHONE' => $USER['PHONE'],
			'TOKEN' => $USER['TOKEN'],
			'EMAIL' => $USER['EMAIL'],
			'NAME' => $USER['NAME'],
			'SURNAME' => $USER['SURNAME'],
			'USERNAME' => $USER['USERNAME'],
			//'JOIN_DATE' => date(DATE_ISO8601, strtotime($USER['JOIN_DATE'])),
			'ADMIN' => $ADMIN,
			'ACTIVE' => $ACTIVE,
			'STAFF' => $STAFF,
			'WORKING_HOURS' => $WORKING_HOURS_DATA,
			'PRIVILEGES' => $data_PRIVILEGES,
			'TICKETS' => $TICKETS_DATA,
			'LOGS' => $DATA_LOGS,
			'STATS' => GET_STATS_BY_STAFF($USER['ID']),
		);
		echo json_encode($DATA_USER);
	}

	function GET_STAFF_LOGGED_IN()
	{
		$USER = $this->db->get_where('USERS', array('ID' => $_SESSION['USER_ID']))->row_array();
		$PERMISSIONS = GET_ALL_PERMISSIONS();
		$PRIVILEGES = GET_PRIVILEGES();
		$arr = array();
		foreach ($PRIVILEGES as $PERMISSION) {
			if ($PERMISSION['USER_ID'] == $USER['ID']) {
				array_push($arr, $PERMISSION['PERMISSION_ID']);
			}
		}
		$data_PRIVILEGES = array();
		foreach ($PERMISSIONS as $PERMISSION) {
			$data_PRIVILEGES[] = array(
				'ID' => $PERMISSION['ID'],
				'NAME' => $PERMISSION['NAME'],
				'VALUE' => '' . (array_search($PERMISSION['ID'], $arr) !== FALSE) ? true : false . ''
			);
		}
		switch ($USER['ADMIN']) {
			case 'true':
				$ADMIN = true;
				break;
			case 'false':
				$ADMIN = false;
				break;
		}
		switch ($USER['STAFF']) {
			case 'true':
				$STAFF = true;
				break;
			case 'false':
				$STAFF = false;
				break;
		}
		switch ($USER['ACTIVE']) {
			case 'true':
				$ACTIVE = true;
				break;
			case 'false':
				$ACTIVE = false;
				break;
		}
		$WORKING_HOURS = $this->db->select('*')->get_where('WORKING_HOURS', array('USER_ID' => $USER['ID']))->row_array();
		if ($WORKING_HOURS) {
			$WORKING_HOURS_DATA = json_decode($WORKING_HOURS['WORKING_HOURS'], true);
		} else {
			$WORKING_HOURS_DATA = null;
		};
		$TICKETS = $this->db->get_where('TICKETS', array('ASSIGNED_ID' => $USER['ID']))->result_array();
		$TICKETS_DATA = array();
		foreach ($TICKETS as $TICKET) {
			$TICKET_USER = $this->GET_USER($TICKET['USER_ID']);
			$SEEN_BY = $this->GET_USER($TICKET['SEEN_BY']);
			$ASSIGNED = $this->GET_USER($TICKET['ASSIGNED_ID']);
			$CLOSER = $this->GET_USER($TICKET['CLOSER_ID']);
			if ($ASSIGNED) {
				$ASSIGNED_FLAG = $ASSIGNED;
			} else {
				$ASSIGNED_FLAG = false;
			}
			$CATEGORY = $this->db->get_where('CATEGORIES', array('ID' => $TICKET['CATEGORY_ID']))->row_array();
			$DEPARTMENT = $this->db->get_where('DEPARTMENTS', array('ID' => $TICKET['DEPARTMENT_ID']))->row_array();
			switch ($TICKET['STATUS']) {
				case '1':
					$STATUS =  GET_PHRASE('Opened');
					break;
				case '2':
					$STATUS =  GET_PHRASE('Assigned');
					break;
				case '3':
					$STATUS =  GET_PHRASE('Replied');
					break;
				case '4':
					$STATUS =  GET_PHRASE('Closed');
					break;
			};
			$TICKETS_DATA[] = array(
				'ID' => $TICKET['ID'],
				'TOKEN' => $TICKET['TOKEN'],
				'CREATED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CREATED_DATE'])),
				'USER' => $TICKET_USER,
				'SEEN_BY' => $SEEN_BY,
				'SEEN_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['SEEN_DATE'])),
				'ASSIGNED' => $ASSIGNED_FLAG,
				'ASSIGNED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['ASSIGNED_DATE'])),
				'CLOSER' => $CLOSER,
				'CLOSED_DATE' =>  date(DATE_ISO8601, strtotime($TICKET['CLOSED_DATE'])),
				'SUBJECT' => $TICKET['SUBJECT'],
				'DETAIL' => $TICKET['DETAIL'],
				'PRIORITY' => $TICKET['PRIORITY'],
				'PROCESS' => $TICKET['PROCESS'],
				'STATUS' => $TICKET['STATUS'],
				'STATUS_NAME' => $STATUS,
				'CATEGORY' => $CATEGORY,
				'CATEGORY_ID' => $TICKET['CATEGORY_ID'],
				'DEPARTMENT' => $DEPARTMENT,
				'DEPARTMENT_ID' => $TICKET['DEPARTMENT_ID'],
			);
		};
		$LOGS = $this->db->limit(100)->order_by("ID", "desc")->get_where('LOGS', array('RELATION_TYPE' => 'TICKET', 'USER_ID' => $USER['ID']))->result_array();
		if ($LOGS) {
			$DATA_LOGS = array();
			foreach ($LOGS as $LOG) {
				$LOG_USER = $this->GET_USER($LOG['USER_ID']);
				$DATA_LOGS[] = array(
					'ID' => $LOG['ID'],
					'USER' => $LOG_USER,
					'DATE' => date(DATE_ISO8601, strtotime($LOG['DATE'])),
					'DETAIL' => $LOG['DETAIL'],
				);
			}
		} else {
			$DATA_LOGS = null;
		}
		$DATA_USER = array(
			'ID' => $USER['ID'],
			'CLIENT_ID' => $USER['CLIENT_ID'],
			'DEPARTMENT_ID' => $USER['DEPARTMENT_ID'],
			'LANGUAGE' => $USER['LANGUAGE'],
			'ADDRESS' => $USER['ADDRESS'],
			'PHONE' => $USER['PHONE'],
			'TOKEN' => $USER['TOKEN'],
			'EMAIL' => $USER['EMAIL'],
			'NAME' => $USER['NAME'],
			'SURNAME' => $USER['SURNAME'],
			'USERNAME' => $USER['USERNAME'],
			//'JOIN_DATE' => date(DATE_ISO8601, strtotime($USER['JOIN_DATE'])),
			'ADMIN' => $ADMIN,
			'ACTIVE' => $ACTIVE,
			'STAFF' => $STAFF,
			'WORKING_HOURS' => $WORKING_HOURS_DATA,
			'PRIVILEGES' => $data_PRIVILEGES,
			'TICKETS' => $TICKETS_DATA,
			'LOGS' => $DATA_LOGS,
			'STATS' => GET_STATS_BY_STAFF($USER['ID']),
		);
		echo json_encode($DATA_USER);
	}

	function UPDATE_PROFILE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$USER = $this->db->get_where('USERS', array('ID' => $this->input->post('ID')))->row_array();
			if ("" == trim($this->input->post('PASSWORD'))) {
				$PASS = $USER['PASSWORD'];
			} else {
				$PASS = password_hash($this->input->post('PASSWORD'), PASSWORD_BCRYPT);
			}
			$PARAMS = array(
				'NAME' =>  $this->input->post('NAME'),
				'SURNAME' => $this->input->post('SURNAME'),
				'PHONE' =>  $this->input->post('PHONE'),
				'ADDRESS' =>  $this->input->post('ADDRESS'),
				'LANGUAGE' =>  $this->input->post('LANGUAGE'),
				'EMAIL' =>  $this->input->post('EMAIL'),
				'PASSWORD' => $PASS,
			);
			if ($_SESSION['STAFF'] == 'true' ||  $_SESSION['ADMIN'] == 'true') {
				$this->db->where('USER_ID', $this->input->post('ID'))->update('WORKING_HOURS', array('WORKING_HOURS' => $this->input->post('WORKING_HOURS')));
			}
			return $this->db->where('ID', $this->input->post('ID'))->update('USERS', $PARAMS);
		} else {
			echo json_encode(false);
		}
	}

	function UPDATE_USER_LANGUAGE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->where('ID', $_SESSION['USER_ID'])->update('USERS', array('LANGUAGE' => $this->input->post('KEY')));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function UPDATE_PRIVILEGE($ID, $VALUE, $PERMISSION_ID)
	{
		if ($_SESSION['ADMIN'] == 'true') {
			if ($VALUE != 'false') {
				$PARAMS = array(
					'USER_ID' => (int) $ID,
					'PERMISSION_ID' => (int) $PERMISSION_ID
				);
				$this->db->insert('PRIVILEGES', $PARAMS);
				echo json_encode(true);
			} else {
				$RESPONSE = $this->db->delete('PRIVILEGES', array('USER_ID' => $ID, 'PERMISSION_ID' => $PERMISSION_ID));
				echo json_encode(true);
			}
		} else {
			$this->output
				->set_status_header(403)
				->set_content_type('application/json', 'utf-8')
				->set_output(json_encode(array('STATUS' => 'NO_PERMISSION'), JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES))
				->_display();
			exit;
		}
	}

	function GET_DEPARTMENTS()
	{
		$DEPARTMENTS = $this->db->get_where('DEPARTMENTS')->result_array();
		$DATA_DEPARTMENTS = array();
		foreach ($DEPARTMENTS as $DEPARTMENT) {
			$PROCESSES = $this->db->get_where('PROCESSES', array('DEPARTMENT_ID' =>  $DEPARTMENT['ID']))->result_array();
			$DATA_DEPARTMENTS[] = array(
				'ID' => (int) $DEPARTMENT['ID'],
				'NAME' =>  $DEPARTMENT['NAME'],
				'PROCESSES' =>  $PROCESSES,
				'TOTAL_COUNTS' => $this->db->get_where('TICKETS', array('DEPARTMENT_ID' =>  $DEPARTMENT['ID']))->num_rows(),
			);
		};
		echo json_encode($DATA_DEPARTMENTS);
	}

	function GET_CATEGORIES()
	{
		$CATEGORIES = $this->db->get_where('CATEGORIES')->result_array();
		echo json_encode($CATEGORIES);
	}

	function UPDATE_STAFF()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$USER = $this->db->get_where('USERS', array('ID' => $this->input->post('ID')))->row_array();
			if ("" == trim($this->input->post('PASSWORD'))) {
				$PASS = $USER['PASSWORD'];
			} else {
				$PASS = password_hash($this->input->post('PASSWORD'), PASSWORD_BCRYPT);
			}
			$PARAMS = array(
				'NAME' =>  $this->input->post('NAME'),
				'SURNAME' => $this->input->post('SURNAME'),
				'PHONE' =>  $this->input->post('PHONE'),
				'ADDRESS' =>  $this->input->post('ADDRESS'),
				'DEPARTMENT_ID' =>  $this->input->post('DEPARTMENT_ID'),
				'LANGUAGE' =>  $this->input->post('LANGUAGE'),
				'EMAIL' =>  $this->input->post('EMAIL'),
				'STAFF' =>  $this->input->post('STAFF'),
				'ADMIN' =>  $this->input->post('ADMIN'),
				'ACTIVE' =>  $this->input->post('ACTIVE'),
				'PASSWORD' => $PASS,
			);
			if ($_SESSION['STAFF'] == 'true' ||  $_SESSION['ADMIN'] == 'true') {
				$this->db->where('USER_ID', $this->input->post('ID'))->update('WORKING_HOURS', array('WORKING_HOURS' => $this->input->post('WORKING_HOURS')));
			}
			return $this->db->where('ID', $this->input->post('ID'))->update('USERS', $PARAMS);
		} else {
			echo json_encode(false);
		}
	}

	function REMOVE_STAFF()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->delete('USERS', array('ID' => $this->input->post('ID')));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function CREATE_STAFF()
	{
		if (isset($_POST) && count($_POST) > 0) {
			if ($_SESSION['STAFF'] == 'true' ||  $_SESSION['ADMIN'] == 'true') {
				$DATA = array(
					'TOKEN' => CREATE_TOKEN(date('Y-m-d H:i:s')),
					'USERNAME' => GENERATE_USERNAME($this->input->post('EMAIL')),
					'NAME' =>  $this->input->post('NAME'),
					'SURNAME' => $this->input->post('SURNAME'),
					'PHONE' =>  $this->input->post('PHONE'),
					'ADDRESS' =>  $this->input->post('ADDRESS'),
					'DEPARTMENT_ID' =>  $this->input->post('DEPARTMENT_ID'),
					'LANGUAGE' =>  $this->input->post('LANGUAGE'),
					'EMAIL' =>  $this->input->post('EMAIL'),
					'STAFF' =>  $this->input->post('STAFF'),
					'ADMIN' =>  $this->input->post('ADMIN'),
					'PASSWORD' => password_hash($this->input->post('PASSWORD'), PASSWORD_BCRYPT)
				);
				if ($this->input->post('PARENT_CLIENT')) {
					$DATA['CLIENT_ID'] = $this->input->post('PARENT_CLIENT');
				}
				$RESPONSE = $this->db->insert('USERS', $DATA);
				$USER_ID = $this->db->insert_id();
				$this->db->insert('WORKING_HOURS', array(
					'USER_ID' => $USER_ID,
					'WORKING_HOURS' => $this->input->post('WORKING_HOURS'),
				));
				//CREATE PRIVILEGES
				$PRIVILEGES = json_decode($this->input->post('PRIVILEGES'), true);
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
			} else {
				if (is_null($_SESSION['CLIENT_ID'])) {
					$CLIENT = $_SESSION['TOKEN'];
				} else {
					$CLIENT = $_SESSION['CLIENT_ID'];
				}
				$DATA = array(
					'TOKEN' => CREATE_TOKEN(date('Y-m-d H:i:s')),
					'USERNAME' => GENERATE_USERNAME($this->input->post('EMAIL')),
					'NAME' =>  $this->input->post('NAME'),
					'SURNAME' => $this->input->post('SURNAME'),
					'PHONE' =>  $this->input->post('PHONE'),
					'CLIENT_ID' =>  $CLIENT,
					'ADDRESS' =>  $this->input->post('ADDRESS'),
					'EMAIL' =>  $this->input->post('EMAIL'),
					'STAFF' =>  $this->input->post('STAFF'),
					'ADMIN' =>  $this->input->post('ADMIN'),
					'PASSWORD' => password_hash($this->input->post('PASSWORD'), PASSWORD_BCRYPT)
				);
				$RESPONSE = $this->db->insert('USERS', $DATA);
				$USER_ID = $this->db->insert_id();
				$this->db->insert('WORKING_HOURS', array(
					'USER_ID' => $USER_ID,
					'WORKING_HOURS' => $this->input->post('WORKING_HOURS'),
				));
			}
		} else {
			echo json_encode(false);
		}
	}

	public function UPLOAD_ATTACHMENT()
	{
		$DATA = array();
		$config['upload_path']       = '../assets/uploads/ticket-attachments/';
		$config['allowed_types'] = 'zip|rar|tar|gif|jpg|png|jpeg|pdf|doc|docx|xls|xlsx|mp4|txt|csv|ppt|opt';
		$config['encrypt_name'] = true;
		$this->load->library('upload', $config);
		$this->upload->initialize($config);
		if (!$this->upload->do_upload('file')) {
			$DATA = array('STATUS' => false);
			echo json_encode($DATA);
		} else {
			$UPLOADED_FILE_DETAILS = $this->upload->data();
			$DATA = array(
				'STATUS' => true,
				'FILE_NAME' => $UPLOADED_FILE_DETAILS['file_name'],
				'FILE_TYPE' => $UPLOADED_FILE_DETAILS['file_type'],
				'FILE_SIZE' => $UPLOADED_FILE_DETAILS['file_size'],
			);
			echo json_encode($DATA);
		}
	}

	public function UPLOAD_APP_LOGO()
	{
		unlink("../assets/img/app-logo.png");
		$DATA = array();
		$config['upload_path']       = '../assets/img';
		$config['allowed_types'] = 'gif|jpg|png|jpeg';
		$config['file_name'] = 'app-logo.png';
		$this->load->library('upload', $config);
		$this->upload->initialize($config);
		if (!$this->upload->do_upload('file')) {
			$DATA = array('STATUS' => false);
			echo json_encode($DATA);
		} else {
			$UPLOADED_FILE_DETAILS = $this->upload->data();
			$DATA = array(
				'STATUS' => true,
				'FILE_NAME' => $UPLOADED_FILE_DETAILS['file_name'],
				'FILE_TYPE' => $UPLOADED_FILE_DETAILS['file_type'],
				'FILE_SIZE' => $UPLOADED_FILE_DETAILS['file_size'],
			);
			echo json_encode($DATA);
		}
	}

	public function UPLOAD_APP_ICON()
	{
		unlink("../assets/img/logo.png");
		$DATA = array();
		$config['upload_path']       = '../assets/img';
		$config['allowed_types'] = 'gif|jpg|png|jpeg';
		$config['file_name'] = 'logo.png';
		$this->load->library('upload', $config);
		$this->upload->initialize($config);
		if (!$this->upload->do_upload('file')) {
			$DATA = array('STATUS' => false);
			echo json_encode($DATA);
		} else {
			$UPLOADED_FILE_DETAILS = $this->upload->data();
			$DATA = array(
				'STATUS' => true,
				'FILE_NAME' => $UPLOADED_FILE_DETAILS['file_name'],
				'FILE_TYPE' => $UPLOADED_FILE_DETAILS['file_type'],
				'FILE_SIZE' => $UPLOADED_FILE_DETAILS['file_size'],
			);
			echo json_encode($DATA);
		}
	}

	public function uploadCkeditor()
	{

		$config['upload_path']       = '../assets/uploads/article-photos/';

		$config['allowed_types'] = 'zip|rar|tar|gif|jpg|png|jpeg|pdf|doc|docx|xls|xlsx|mp4|txt|csv|ppt|opt';
		$this->load->library('upload', $config);
		if (!$this->upload->do_upload('upload')) {
			echo json_encode(array('error' => $this->upload->display_errors()));
		} else {
			$file_data = $this->upload->data();
			$DATA = array(
				"fileName" => $file_data['file_name'],
				"uploaded" => 1,
				"url" => "assets/uploads/article-photos/" . $file_data['file_name']
			);
			echo json_encode($DATA);
		}
	}

	public function REMOVE_FILE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$FILE = $this->input->post('FILE');
			if (isset($FILE['ID'])) {
				$DO = $this->db->delete('FILES', array('ID' => $FILE['ID']));
			}
			unlink("../assets/uploads/ticket-attachments/" . $FILE['FILE_NAME']);
			echo true;
		} else {
			echo false;
		}
	}

	public function DOWNLOAD_FILE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->load->helper('download');
			$FILE = $this->input->post('FILE');
			$data = file_get_contents(base_url("../assets/uploads/ticket-attachments/" . $FILE['FILE_NAME']));
			force_download($FILE['FILE_NAME'], $data);
		} else {
			echo false;
		}
	}

	function CHANGE_COLOR()
	{
		if ($this->input->post('COLOR')) {

			$RESPONSE = $this->db->where('NAME', 'APP')->update('OPTIONS', array('APP_COLOR' => $this->input->post('COLOR')));
			$COLOR = $this->input->post('COLOR');
			$COLORS = array(
				'PRIMARY_COLOR' => $COLOR,
				'SECONDARY_COLOR' => SET_COLOR($COLOR, -15),
				'TERTIARY_COLOR' => SET_COLOR($COLOR, 5),
				'FOURTH_COLOR' => SET_COLOR($COLOR, 50),
			);
			echo json_encode($COLORS);
		} else {
			echo false;
		}
	}

	function UPDATE_OPTIONS()
	{
		if (isset($_POST) && count($_POST) > 0) {
			if ($_SESSION['STAFF'] == 'true' ||  $_SESSION['ADMIN'] == 'true') {
				$PARAMS = array(
					'NAME' =>  $this->input->post('NAME'),
					'HELPDESK_STATUS' => $this->input->post('HELPDESK_STATUS'),
					'VACATION_MODE' =>  $this->input->post('VACATION_MODE'),
					'DEFAULT_DEPARTMENT' =>  $this->input->post('DEFAULT_DEPARTMENT'),
					'APPLICATION_NAME' =>  $this->input->post('APPLICATION_NAME'),
					'APP_COLOR' =>  $this->input->post('APP_COLOR'),
					'LANG' =>  $this->input->post('LANG'),
					'DESK_URL' =>  $this->input->post('DESK_URL'),
					'MAX_PAGE_SIZE' =>  $this->input->post('MAX_PAGE_SIZE'),
					'DEFAULT_LOCALE' =>  $this->input->post('DEFAULT_LOCALE'),
					'DEFAULT_TIME_ZONE' =>  $this->input->post('DEFAULT_TIME_ZONE'),
					'BUSINESS_HOURS' =>  $this->input->post('BUSINESS_HOURS'),
				);
				return $this->db->where('NAME', 'APP')->update('OPTIONS', $PARAMS);
			} else {
				return false;
			}
		} else {
			echo json_encode(false);
		}
	}

	function UPDATE_EMAIL_OPTIONS()
	{
		if (isset($_POST) && count($_POST) > 0) {
			if ($_SESSION['ADMIN'] == 'true') {
				$PARAMS = array(
					'EMAIL_ENCRYPTION' =>  $this->input->post('EMAIL_ENCRYPTION'),
					'SMTP_HOST' => $this->input->post('SMTP_HOST'),
					'SMTP_PORT' =>  $this->input->post('SMTP_PORT'),
					'SMTP_USER' =>  $this->input->post('SMTP_USER'),
					'SMTP_PASS' =>  $this->input->post('SMTP_PASS'),
					'NO_REPLY_EMAIL' =>  $this->input->post('NO_REPLY_EMAIL'),
				);
				return $this->db->where('NAME', 'APP')->update('OPTIONS', $PARAMS);
			} else {
				return false;
			}
		} else {
			echo json_encode(false);
		}
	}

	// CUSTOM FIELDS //

	function GET_CUSTOM_FIELDS()
	{
		$CUSTOM_FIELDS = $this->db->get_where('CUSTOM_FIELDS', array('RELATION_TYPE' => 'TICKET'))->result_array();
		$DATA_CUSTOM_FIELDS = array();
		foreach ($CUSTOM_FIELDS as $FIELD) {
			if ($FIELD['DATA']) {
				switch ($FIELD['TYPE']) {
					case 'input':
						$LEFT_DATA = $FIELD['DATA'];
						$SELECT_OPTIONS = 0;
						break;
					case 'date':
						$LEFT_DATA = date(DATE_ISO8601, strtotime($FIELD['DATA']));
						$SELECT_OPTIONS = 0;
						break;
					case 'number':
						$LEFT_DATA = $FIELD['DATA'];
						$SELECT_OPTIONS = 0;
						break;
					case 'textarea':
						$LEFT_DATA = $FIELD['DATA'];
						$SELECT_OPTIONS = 0;
						break;
					case 'select':
						$LEFT_DATA = json_decode($FIELD['DATA']);
						$SELECT_OPTIONS = json_decode($FIELD['DATA']);
						break;
					case 'radio':
						$LEFT_DATA = json_decode($FIELD['DATA']);
						$SELECT_OPTIONS = json_decode($FIELD['DATA']);
						break;
				}
			} else {
				$LEFT_DATA = $FIELD['DATA'];
				$SELECT_OPTIONS = null;
			}
			$DATA_CUSTOM_FIELDS[] = array(
				'ID' => $FIELD['ID'],
				'NAME' => $FIELD['NAME'],
				'TYPE' => $FIELD['TYPE'],
				'REQUIRED' =>  $FIELD['REQUIRED'] === 'true' ? true : false,
				'DESCRIPTION' => $FIELD['DESCRIPTION'],
				'ORDER' => $FIELD['ORDER'],
				'DATA' => $LEFT_DATA,
				'SELECT_OPTIONS' => $SELECT_OPTIONS,
				'RELATION_TYPE' => $FIELD['RELATION_TYPE'],
				'CONDITION' =>  json_decode($FIELD['CONDITION'], true),
				'APPLICANT_TYPE' => $FIELD['APPLICANT_TYPE'],
				'ACTIVE' => $FIELD['ACTIVE'] === 'true' ? true : false,
				'PERMISSIONS' => $FIELD['PERMISSIONS'] === 'true' ? true : false,
			);
		};
		echo json_encode($DATA_CUSTOM_FIELDS);
	}

	function ADD_CUSTOM_FIELD()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$PARAMS = array(
				'NAME' => $this->input->post('NAME'),
				'DESCRIPTION' => $this->input->post('DESCRIPTION'),
				'TYPE' => $this->input->post('TYPE'),
				'ORDER' => $this->input->post('ORDER'),
				'DATA' => $this->input->post('DATA'),
				'RELATION_TYPE' => $this->input->post('RELATION_TYPE'),
				'CONDITION' => $this->input->post('CONDITION'),
				'APPLICANT_TYPE' => $this->input->post('APPLICANT_TYPE'),
				'REQUIRED' => $this->input->post('REQUIRED'),
				'ACTIVE' => $this->input->post('ACTIVE'),
				'PERMISSIONS' => $this->input->post('PERMISSIONS'),
			);
			$this->db->insert('CUSTOM_FIELDS', $PARAMS);
			$FIELD = $this->db->get_where('CUSTOM_FIELDS', array('ID' =>  $this->db->insert_id()))->row_array();
			if ($FIELD['DATA']) {
				switch ($FIELD['TYPE']) {
					case 'input':
						$LEFT_DATA = $FIELD['DATA'];
						$SELECT_OPTIONS = 0;
						break;
					case 'date':
						$LEFT_DATA = date(DATE_ISO8601, strtotime($FIELD['DATA']));
						$SELECT_OPTIONS = 0;
						break;
					case 'number':
						$LEFT_DATA = $FIELD['DATA'];
						$SELECT_OPTIONS = 0;
						break;
					case 'textarea':
						$LEFT_DATA = $FIELD['DATA'];
						$SELECT_OPTIONS = 0;
						break;
					case 'select':
						$LEFT_DATA = json_decode($FIELD['DATA']);
						$SELECT_OPTIONS = json_decode($FIELD['DATA']);
						break;
					case 'radio':
						$LEFT_DATA = json_decode($FIELD['DATA']);
						$SELECT_OPTIONS = json_decode($FIELD['DATA']);
						break;
				}
			} else {
				$LEFT_DATA = $FIELD['DATA'];
				$SELECT_OPTIONS = null;
			}
			$DATA_CUSTOM_FIELDS = array(
				'ID' => $FIELD['ID'],
				'NAME' => $FIELD['NAME'],
				'DESCRIPTION' => $FIELD['DESCRIPTION'],
				'TYPE' => $FIELD['TYPE'],
				'REQUIRED' => $FIELD['REQUIRED'],
				'ORDER' => $FIELD['ORDER'],
				'DATA' => $LEFT_DATA,
				'SELECT_OPTIONS' => $SELECT_OPTIONS,
				'RELATION_TYPE' => $FIELD['RELATION_TYPE'],
				'CONDITION' => $FIELD['CONDITION'],
				'APPLICANT_TYPE' => $FIELD['APPLICANT_TYPE'],
				'ACTIVE' => $FIELD['ACTIVE'] === 'true' ? true : false,
				'PERMISSIONS' => $FIELD['PERMISSIONS'] === 'true' ? true : false,
			);
			echo json_encode($DATA_CUSTOM_FIELDS);
		} else {
			echo false;
		}
	}

	function UPDATE_CUSTOM_FIELD($ID)
	{
		if (isset($ID)) {
			if (isset($_POST) && count($_POST) > 0) {
				$PARAMS = array(
					'NAME' => $this->input->post('NAME'),
					'DESCRIPTION' => $this->input->post('DESCRIPTION'),
					'TYPE' => $this->input->post('TYPE'),
					'ORDER' => $this->input->post('ORDER'),
					'DATA' => $this->input->post('DATA'),
					'RELATION_TYPE' => $this->input->post('RELATION_TYPE'),
					'CONDITION' => $this->input->post('CONDITION'),
					'APPLICANT_TYPE' => $this->input->post('APPLICANT_TYPE'),
					'REQUIRED' => $this->input->post('REQUIRED'),
					'ACTIVE' => $this->input->post('ACTIVE'),
					'PERMISSIONS' => $this->input->post('PERMISSIONS'),
				);
				$this->db->where('ID', $ID);
				return $this->db->update('CUSTOM_FIELDS', $PARAMS);
			}
		} else {
			echo 'Özel Alan Ekleme Sorunu';
		}
	}

	function REMOVE_CUSTOM_FIELD($id)
	{
		if (isset($id)) {
			$response = $this->db->delete('CUSTOM_FIELDS', array('id' => $id));
			if ($response) {
				echo 'true';
			} else {
				echo 'false';
			}
		} else {
			echo 'false';
		}
	}

	// CUSTOM FIELDS //

	function ASSIGN_STAFF()
	{
		if ($this->input->post('ASSIGNED_STAFF_ID')) {
			$RESPONSE = $this->db->where('ID', $this->input->post('TICKET_ID'))->update('TICKETS', array('ASSIGNED_ID' => $this->input->post('ASSIGNED_STAFF_ID'), 'ASSIGNED_DATE' => date('Y-m-d H:i:s')));
			$SESSIONED_USER = $this->GET_USER($_SESSION['USER_ID']);
			$ASSIGNED_USER = $this->GET_USER($this->input->post('ASSIGNED_STAFF_ID'));
			$TICKET = $this->db->get_where('TICKETS', array('ID' => $this->input->post('TICKET_ID')))->row_array();
			$this->db->insert('LOGS', array('USER_ID' => $this->input->post('ASSIGNED_STAFF_ID'), 'RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $this->input->post('TICKET_ID'), 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STAFF_ASSIGNED'), $SESSIONED_USER['NAME'], $ASSIGNED_USER['NAME'],  $this->input->post('TICKET_TOKEN'), $this->input->post('TICKET_TOKEN'))));
			$this->db->insert('NOTIFICATIONS', array(
				'TITLE' => 'New Assign',
				'RECEIVER' => $this->input->post('ASSIGNED_STAFF_ID'),
				'RELATION_TYPE' => 'TICKET',
				'RELATED_ID' => $this->input->post('TICKET_ID'),
				'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_ASSIGNED_YOU'), $SESSIONED_USER['NAME'],  $this->input->post('TICKET_TOKEN'), $this->input->post('TICKET_TOKEN'))
			));
			$this->db->insert('NOTIFICATIONS', array(
				'TITLE' => 'New Assign',
				'RECEIVER' => $TICKET['USER_ID'],
				'RELATION_TYPE' => 'TICKET',
				'RELATED_ID' => $this->input->post('TICKET_ID'),
				'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STAFF_ASSIGNED'), $SESSIONED_USER['NAME'], $ASSIGNED_USER['NAME'],  $this->input->post('TICKET_TOKEN'), $this->input->post('TICKET_TOKEN'))
			));
			echo json_encode($RESPONSE);
		} else {
			echo false;
		}
	}

	function CHANGE_TICKET_STATUS()
	{
		if ($this->input->post('STATUS')) {
			if ($this->input->post('STATUS') != 4) {
				switch ($this->input->post('STATUS')) {
					case 1:
						$STATUS_NAME = GET_PHRASE('Opened');
						break;
					case 2:
						$STATUS_NAME = GET_PHRASE('Assigned');
						break;
					case 3:
						$STATUS_NAME = GET_PHRASE('Replied');
						break;
				}
				$TICKET = $this->db->get_where('TICKETS', array('ID' => $this->input->post('TICKET_ID')))->row_array();
				$RESPONSE = $this->db->where('ID', $this->input->post('TICKET_ID'))->update('TICKETS', array('STATUS' => $this->input->post('STATUS')));
				$SESSIONED_USER = $this->GET_USER($_SESSION['USER_ID']);
				$this->db->insert('LOGS', array('CLIENT' => $this->input->post('CLIENT'), 'USER_ID' => $_SESSION['USER_ID'], 'RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $this->input->post('TICKET_ID'), 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], $STATUS_NAME)));
				$this->db->insert('NOTIFICATIONS', array(
					'TITLE' => 'Status Changed',
					'RECEIVER' => $TICKET['USER_ID'],
					'RELATION_TYPE' => 'TICKET',
					'RELATED_ID' => $this->input->post('TICKET_ID'),
					'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], $STATUS_NAME)
				));
				$this->db->insert('NOTIFICATIONS', array(
					'TITLE' => 'Status Changed',
					'RECEIVER' => $TICKET['ASSIGNED_ID'],
					'RELATION_TYPE' => 'TICKET',
					'RELATED_ID' => $this->input->post('TICKET_ID'),
					'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], $STATUS_NAME)
				));
				echo json_encode($RESPONSE);
			} else {

				$RESPONSE = $this->db->where('ID', $this->input->post('TICKET_ID'))->update('TICKETS', array(
					'STATUS' => $this->input->post('STATUS'),
					'CLOSER_ID' => $_SESSION['USER_ID'],
					'CLOSED_DATE' =>  date('Y-m-d H:i:s'),
				));
				$TICKET = $this->db->get_where('TICKETS', array('ID' => $this->input->post('TICKET_ID')))->row_array();
				$SESSIONED_USER = $this->GET_USER($_SESSION['USER_ID']);
				$this->db->insert('LOGS', array('CLIENT' => $this->input->post('CLIENT'), 'USER_ID' => $_SESSION['USER_ID'], 'RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $this->input->post('TICKET_ID'), 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], GET_PHRASE('Closed'))));
				$this->db->insert('NOTIFICATIONS', array(
					'TITLE' => 'Status Changed',
					'RECEIVER' => $TICKET['USER_ID'],
					'RELATION_TYPE' => 'TICKET',
					'RELATED_ID' => $this->input->post('TICKET_ID'),
					'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], GET_PHRASE('Closed'))
				));
				$this->db->insert('NOTIFICATIONS', array(
					'TITLE' => 'Status Changed',
					'RECEIVER' => $TICKET['ASSIGNED_ID'],
					'RELATION_TYPE' => 'TICKET',
					'RELATED_ID' => $this->input->post('TICKET_ID'),
					'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], GET_PHRASE('Closed'))
				));
				echo json_encode($RESPONSE);
			}
		} else {
			echo false;
		}
	}

	function CHANGE_TICKET_PROCESS()
	{
		if ($this->input->post('PROCESS')) {
			$RESPONSE = $this->db->where('ID', $this->input->post('TICKET_ID'))->update('TICKETS', array('PROCESS' => $this->input->post('PROCESS')));
			echo json_encode($RESPONSE);
		} else {
			echo false;
		}
	}

	function CHANGE_TICKET_PRIORITY()
	{
		if ($this->input->post('PRIORITY')) {
			$RESPONSE = $this->db->where('ID', $this->input->post('TICKET_ID'))->update('TICKETS', array('PRIORITY' => $this->input->post('PRIORITY')));
			echo json_encode($RESPONSE);
		} else {
			echo false;
		}
	}

	function CHANGE_TICKET_DEPARTMENT()
	{
		if ($this->input->post('DEPARTMENT')) {
			$RESPONSE = $this->db->where('ID', $this->input->post('TICKET_ID'))->update('TICKETS', array('DEPARTMENT_ID' => $this->input->post('DEPARTMENT')));
			echo json_encode($RESPONSE);
		} else {
			echo false;
		}
	}

	function CHANGE_TICKET_SLA_POLICIY()
	{
		if ($this->input->post('SLA_POLICY')) {
			$RESPONSE = $this->db->where('ID', $this->input->post('TICKET_ID'))->update('TICKETS', array('SLA_POLICY' => $this->input->post('SLA_POLICY')));
			echo json_encode($RESPONSE);
		} else {
			echo false;
		}
	}

	function ASSIGN_STAFF_TO_SELECTED_TICKET()
	{
		if ($this->input->post('TICKETS')) {
			$i = 0;
			foreach ($this->input->post('TICKETS') as $APPLICATION) {
				$this->db->where('ID', $APPLICATION['ID'])->update('SOLIDARITY_APPLICATIONS', array('ASSIGNED_ID' => $this->input->post('STAFF_ID'), 'ASSIGNED_DATE' => date('Y-m-d H:i:s')));
				$i++;
			};
			echo 'true';
		} else {
			echo 'false';
		}
	}

	function SET_STATUS_TO()
	{
		$TICKETS = $this->input->post('TICKETS');
		if (isset($TICKETS)) {
			$i = 0;
			foreach ($TICKETS as $TICKET) {
				if ($this->input->post('STATUS') != 4) {
					switch ($this->input->post('STATUS')) {
						case 1:
							$STATUS_NAME = GET_PHRASE('Opened');
							break;
						case 2:
							$STATUS_NAME = GET_PHRASE('Assigned');
							break;
						case 3:
							$STATUS_NAME = GET_PHRASE('Replied');
							break;
					}
					$TICKET = $this->db->get_where('TICKETS', array('ID' => $TICKET['ID']))->row_array();
					$RESPONSE = $this->db->where('ID', $TICKET['ID'])->update('TICKETS', array('STATUS' => $this->input->post('STATUS')));
					$SESSIONED_USER = $this->GET_USER($_SESSION['USER_ID']);
					$this->db->insert('LOGS', array('CLIENT' => $TICKET['CLIENT'], 'USER_ID' => $_SESSION['USER_ID'], 'RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID'], 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], $STATUS_NAME)));
					$this->db->insert('NOTIFICATIONS', array(
						'TITLE' => 'Status Changed',
						'RECEIVER' => $TICKET['USER_ID'],
						'RELATION_TYPE' => 'TICKET',
						'RELATED_ID' => $TICKET['ID'],
						'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], $STATUS_NAME)
					));
					$this->db->insert('NOTIFICATIONS', array(
						'TITLE' => 'Status Changed',
						'RECEIVER' => $TICKET['ASSIGNED_ID'],
						'RELATION_TYPE' => 'TICKET',
						'RELATED_ID' => $TICKET['ID'],
						'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], $STATUS_NAME)
					));
				} else {
					$RESPONSE = $this->db->where('ID', $TICKET['ID'])->update('TICKETS', array(
						'STATUS' => $this->input->post('STATUS'),
						'CLOSER_ID' => $_SESSION['USER_ID'],
						'CLOSED_DATE' =>  date('Y-m-d H:i:s'),
					));
					$TICKET = $this->db->get_where('TICKETS', array('ID' => $TICKET['ID']))->row_array();
					$SESSIONED_USER = $this->GET_USER($_SESSION['USER_ID']);
					$this->db->insert('LOGS', array('CLIENT' => $TICKET['CLIENT'], 'USER_ID' => $_SESSION['USER_ID'], 'RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID'], 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], GET_PHRASE('Closed'))));
					$this->db->insert('NOTIFICATIONS', array(
						'TITLE' => 'Status Changed',
						'RECEIVER' => $TICKET['USER_ID'],
						'RELATION_TYPE' => 'TICKET',
						'RELATED_ID' => $TICKET['ID'],
						'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], GET_PHRASE('Closed'))
					));
					$this->db->insert('NOTIFICATIONS', array(
						'TITLE' => 'Status Changed',
						'RECEIVER' => $TICKET['ASSIGNED_ID'],
						'RELATION_TYPE' => 'TICKET',
						'RELATED_ID' => $TICKET['ID'],
						'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], GET_PHRASE('Closed'))
					));
				}
				$i++;
			};
			echo json_encode('true');
		} else {
			echo json_encode('false');
		}
	}

	function SET_PRIORITY_TO()
	{
		$TICKETS = $this->input->post('TICKETS');
		if (isset($TICKETS)) {
			$i = 0;
			foreach ($TICKETS as $TICKET) {
				$this->db->where('ID', $TICKET['ID'])->update('TICKETS', array('PRIORITY' =>  $this->input->post('PRIORITY')));
				$i++;
			};
			echo 'true';
		} else {
			echo 'false';
		}
	}

	function MARK_SELECTED_TICKETS_AS_SPAM()
	{
		$TICKETS = $this->input->post('TICKETS');
		if (isset($TICKETS)) {
			$i = 0;
			foreach ($TICKETS as $TICKET) {
				$this->db->where('ID',  $TICKET['ID'])->update('TICKETS', array('SPAM' => 'true'));
				$i++;
			};
			echo 'true';
		} else {
			echo 'false';
		}
	}

	function REMOVE_SELECTED_TICKETS()
	{
		if ($_SESSION["ADMIN"] == 'true' || $_SESSION["STAFF"] == 'true') {
			$TICKETS = $this->input->post('TICKETS');
			if (isset($TICKETS)) {
				$i = 0;
				foreach ($TICKETS as $TICKET) {

					$ATTACHMENTS = $this->db->get_where('FILES', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']))->result_array();
					if (isset($ATTACHMENTS)) {
						foreach ($ATTACHMENTS as $KEY) {
							$FILE = APPPATH . '../assets/uploads/ticket-attachments/' . $KEY['FILE_NAME'] . '';
							unlink($FILE);
						}
					}
					$CONVERSATIONS = $this->db->get_where('CONVERSATIONS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']))->result_array();
					if (isset($CONVERSATIONS)) {
						foreach ($CONVERSATIONS as $CONV) {
							$CNV_ATTACHMENTS = $this->db->get_where('FILES', array('RELATION_TYPE' => 'CONVERSATION', 'RELATED_ID' => $CONV['ID']))->result_array();
							if (isset($CNV_ATTACHMENTS)) {
								foreach ($CNV_ATTACHMENTS as $KEY) {
									$FILE = APPPATH . '../assets/uploads/ticket-attachments/' . $KEY['FILE_NAME'] . '';
									unlink($FILE);
								}
							}
						}
					}
					$this->db->delete('SLA_VIOLATIONS', array('TICKET_ID' => $TICKET['ID']));
					$this->db->delete('CONVERSATIONS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']));
					$this->db->delete('NOTES', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']));
					$this->db->delete('FILES', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']));
					$this->db->delete('LOGS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']));
					$this->db->delete('NOTIFICATIONS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']));
					$this->db->delete('TICKETS', array('ID' => $TICKET['ID']));
				}
				$i++;

				echo 'true';
			} else {
				echo 'false';
			}
		} else {
			echo 'false';
		}
	}

	function START_MERGING()
	{
		$TICKETS = $this->input->post('TICKETS');
		if (isset($TICKETS)) {
			$RESULT = array();
			$CHILD_TICKETS = array();
			$i = 0;
			foreach ($TICKETS as $TICKET) {
				if ($TICKET['TOKEN'] !=  $this->input->post('PARENT_TICKET_TOKEN')) {
					$TICKET = $this->db->get_where('TICKETS', array('TOKEN' => $TICKET['TOKEN']))->row_array();
					$PARENT_TICKET = $this->db->get_where('TICKETS', array('TOKEN' => $this->input->post('PARENT_TICKET_TOKEN')))->row_array();
					$RESULT['CHILD_TICKETS'] = $TICKET['ID'];
					$this->db->where('ID',  $TICKET['ID'])->update('TICKETS', array(
						'PARENT_ID' => $PARENT_TICKET['ID'],
						'STATUS' => $this->input->post('CHILD_STATUS')
					));
					$SESSIONED_USER = $this->GET_USER($_SESSION['USER_ID']);
					$this->db->insert('LOGS', array('CLIENT' => $TICKET['CLIENT'], 'USER_ID' => $_SESSION['USER_ID'], 'RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID'], 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_MERGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], $PARENT_TICKET['TOKEN'], $PARENT_TICKET['TOKEN'])));
					$this->db->insert('LOGS', array('CLIENT' => $TICKET['CLIENT'], 'USER_ID' => $_SESSION['USER_ID'], 'RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $PARENT_TICKET['ID'], 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_MERGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], $PARENT_TICKET['TOKEN'], $PARENT_TICKET['TOKEN'])));
					if ($this->input->post('CHILD_STATUS') != 4) {
						switch ($this->input->post('CHILD_STATUS')) {
							case 1:
								$STATUS_NAME = GET_PHRASE('Opened');
								break;
							case 2:
								$STATUS_NAME = GET_PHRASE('Assigned');
								break;
							case 3:
								$STATUS_NAME = GET_PHRASE('Replied');
								break;
						}
						$this->db->where('ID', $TICKET['ID'])->update('TICKETS', array('STATUS' => $this->input->post('CHILD_STATUS')));
						$SESSIONED_USER = $this->GET_USER($_SESSION['USER_ID']);
						$this->db->insert('LOGS', array('CLIENT' => $TICKET['CLIENT'], 'USER_ID' => $_SESSION['USER_ID'], 'RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID'], 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], $STATUS_NAME)));
						$this->db->insert('NOTIFICATIONS', array(
							'TITLE' => 'Status Changed',
							'RECEIVER' => $TICKET['USER_ID'],
							'RELATION_TYPE' => 'TICKET',
							'RELATED_ID' => $TICKET['ID'],
							'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], $STATUS_NAME)
						));
						$this->db->insert('NOTIFICATIONS', array(
							'TITLE' => 'Status Changed',
							'RECEIVER' => $TICKET['ASSIGNED_ID'],
							'RELATION_TYPE' => 'TICKET',
							'RELATED_ID' => $TICKET['ID'],
							'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], $STATUS_NAME)
						));
					} else {
						$this->db->where('ID', $TICKET['ID'])->update('TICKETS', array(
							'STATUS' => $this->input->post('CHILD_STATUS'),
							'CLOSER_ID' => $_SESSION['USER_ID'],
							'CLOSED_DATE' =>  date('Y-m-d H:i:s'),
						));
						$SESSIONED_USER = $this->GET_USER($_SESSION['USER_ID']);
						$this->db->insert('LOGS', array('CLIENT' => $TICKET['CLIENT'], 'USER_ID' => $_SESSION['USER_ID'], 'RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID'], 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], GET_PHRASE('Closed'))));
						$this->db->insert('NOTIFICATIONS', array(
							'TITLE' => 'Status Changed',
							'RECEIVER' => $TICKET['USER_ID'],
							'RELATION_TYPE' => 'TICKET',
							'RELATED_ID' => $TICKET['ID'],
							'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_STATUS_CHANGE'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'], GET_PHRASE('Closed'))
						));
					}
					if ($this->input->post('MERGE_THREADS')) {
						$this->db->where('RELATION_TYPE', 'TICKET')->where('RELATED_ID', $TICKET['ID'])->update('FILES', array(
							'RELATED_ID' => $PARENT_TICKET['ID'],
						));
						$this->db->where('RELATION_TYPE', 'TICKET')->where('RELATED_ID', $TICKET['ID'])->update('CONVERSATIONS', array(
							'RELATED_ID' => $PARENT_TICKET['ID'],
						));
						$this->db->where('RELATION_TYPE', 'TICKET')->where('RELATED_ID', $TICKET['ID'])->update('NOTES', array(
							'RELATED_ID' => $PARENT_TICKET['ID'],
						));
					}
				}
				$i++;
			};
			$RESULT['MERGE_THREADS'] = $this->input->post('MERGE_THREADS');
			$RESULT['PARENT_TICKET_ID'] = $PARENT_TICKET['ID'];
			$RESULT['CHILD_TICKETS'] = $CHILD_TICKETS;
			echo json_encode($RESULT);
		} else {
			echo 'false';
		}
	}

	function MARK_TICKET_AS_SPAM()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->where('ID', $this->input->post('TICKET_ID'))->update('TICKETS', array('SPAM' => 'true'));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function MARK_TICKET_AS_NOT_SPAM()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->where('ID', $this->input->post('TICKET_ID'))->update('TICKETS', array('SPAM' => 'false'));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	function ADD_MESSAGE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$CONVERSATION_DETAIL = array(
				'RELATION_TYPE' => $this->input->post('RELATION_TYPE'),
				'RELATED_ID' => $this->input->post('RELATED_ID'),
				'RECEIVER_ID' => $this->input->post('RECEIVER_ID'),
				'SENDER_ID' => $_SESSION['USER_ID'],
				'DATE' => date('Y-m-d H:i:s'),
				'MESSAGE' => $this->input->post('MESSAGE'),
			);
			$this->db->insert('CONVERSATIONS', $CONVERSATION_DETAIL);
			$CNV_ID = $this->db->insert_id();
			switch ($this->input->post('RELATION_TYPE')) {
				case 'TICKET':
					$TICKET = $this->db->get_where('TICKETS', array('ID' => $this->input->post('RELATED_ID')))->row_array();
					if ($TICKET['REPLIED_DATE'] != '0000-00-00 00:00:00') {
						$this->db->where('ID', $this->input->post('RELATED_ID'))->update('TICKETS', array(
							'LAST_REPLY' => date('Y-m-d H:i:s'),
						));
					} else {
						$this->db->where('ID', $this->input->post('RELATED_ID'))->update('TICKETS', array(
							'REPLIED_DATE' => date('Y-m-d H:i:s'),
							'LAST_REPLY' => date('Y-m-d H:i:s'),
							'ASSIGNED_ID' => $_SESSION['USER_ID'],
							'ASSIGNED_DATE' =>  date('Y-m-d H:i:s'),
							'STATUS' => 3,
						));
					}
					if ($_SESSION['STAFF'] == 'true' ||  $_SESSION['ADMIN'] == 'true') {
						$SESSIONED_USER = $this->GET_USER($_SESSION['USER_ID']);
						$TICKET_USER = $this->GET_USER($TICKET['USER_ID']);
						$this->db->insert('LOGS', array('USER_ID' => $_SESSION['USER_ID'], 'CLIENT' => $TICKET['CLIENT'], 'RELATION_TYPE' => $this->input->post('RELATION_TYPE'), 'RELATED_ID' => $this->input->post('RELATED_ID'), 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_REPLIED'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'])));
						$this->db->insert('NOTIFICATIONS', array(
							'TITLE' => GET_PHRASE('Replied'),
							'RECEIVER' => $TICKET['USER_ID'],
							'RELATION_TYPE' => 'TICKET',
							'RELATED_ID' => $TICKET['ID'],
							'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_REPLIED'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'])
						));
						$TO = $this->GET_USER($TICKET['USER_ID']);
						$MESSAGE = sprintf(GET_PHRASE('LOG_TICKET_REPLIED'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN']);
						$C_URL = APP_OPTIONS()['DESK_URL'] . '#!/tickets/ticket/' . $TICKET['TOKEN'];
						$DATA = array(
							'NAME' => $TICKET_USER['NAME'],
							'MESSAGE' => $MESSAGE,
							'EMAIL' => $TICKET_USER['EMAIL'],
							'URL' => $C_URL,
						);
						$BODY = $this->load->view('email/DEFAULT.php', $DATA, TRUE);
						SEND_EMAIL_TO($TO['EMAIL'], GET_PHRASE('EMAIL_TICKET_REPLIED_TITLE'), $BODY);
					} else {
						$SESSIONED_USER = $this->GET_USER($_SESSION['USER_ID']);
						$this->db->insert('LOGS', array('USER_ID' => $_SESSION['USER_ID'], 'CLIENT' => $TICKET['CLIENT'], 'RELATION_TYPE' => $this->input->post('RELATION_TYPE'), 'RELATED_ID' => $this->input->post('RELATED_ID'), 'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_REPLIED'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'])));
						$this->db->insert('NOTIFICATIONS', array(
							'TITLE' => GET_PHRASE('Replied'),
							'RECEIVER' => $TICKET['ASSIGNED_ID'],
							'RELATION_TYPE' => 'TICKET',
							'RELATED_ID' => $TICKET['ID'],
							'DETAIL' => sprintf(GET_PHRASE('LOG_TICKET_REPLIED'), $SESSIONED_USER['NAME'],  $TICKET['TOKEN'], $TICKET['TOKEN'])
						));
					}
					break;
				case 2:
					$LOG_DETAIL = null;
					break;
			}
			if ($this->input->post('ATTACHMENT')) {
				$i = 0;
				foreach ($this->input->post('ATTACHMENT') as $ATTACHMENT) {
					$this->db->insert('FILES', array(
						'UPLOAD_DATE' => date('Y-m-d H:i:s'),
						'FILE_NAME' => $ATTACHMENT['FILE_NAME'],
						'FILE_TYPE' => $ATTACHMENT['FILE_TYPE'],
						'FILE_SIZE' => $ATTACHMENT['FILE_SIZE'],
						'RELATION_TYPE' => 'CONVERSATION',
						'RELATED_ID' => $CNV_ID,
						'UPLOADER_ID' =>  $_SESSION['USER_ID'],
					));
					$i++;
				};
			}
			echo true;
		}
	}

	function ADD_NOTE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$CONVERSATION_DETAIL = array(
				'RELATION_TYPE' => $this->input->post('RELATION_TYPE'),
				'RELATED_ID' => $this->input->post('RELATED_ID'),
				'USER_ID' => $_SESSION['USER_ID'],
				'DATE' => date('Y-m-d H:i:s'),
				'NOTE' => $this->input->post('NOTE'),
				'PRIVATE' => $this->input->post('PRIVATE'),
			);
			$this->db->insert('NOTES', $CONVERSATION_DETAIL);
			$ATTACHMENTS = $this->input->post('ATTACHMENT');
			$i = 0;
			foreach ($ATTACHMENTS as $ATTACHMENT) {
				$this->db->insert('FILES', array(
					'UPLOAD_DATE' => date('Y-m-d H:i:s'),
					'FILE_NAME' => $ATTACHMENT['FILE_NAME'],
					'FILE_TYPE' => $ATTACHMENT['FILE_TYPE'],
					'FILE_SIZE' => $ATTACHMENT['FILE_SIZE'],
					'RELATION_TYPE' => 'CONVERSATION',
					'RELATED_ID' => $this->db->insert_id(),
					'UPLOADER_ID' =>  $_SESSION['USER_ID'],
				));
				$i++;
			};
			echo true;
		}
	}

	function GET_SLA_POLICIES()
	{
		$SLA_POLICIES = $this->db->get_where('SLA_POLICIES')->result_array();
		echo json_encode($SLA_POLICIES);
	}

	function ADD_SLA()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$SLA_POLICY = array(
				'NAME' => $this->input->post('NAME'),
				'DESCRIPTION' => $this->input->post('DESCRIPTION'),
				'TRIGGER' => $this->input->post('TRIGGER'),
				'VIOLATION_RULES' => $this->input->post('VIOLATION_RULES'),
				'TARGETS' => $this->input->post('TARGETS'),
				'CREATED_DATE' => date('Y-m-d H:i:s'),
				'ACTIVE' => $this->input->post('ACTIVE'),
			);
			$this->db->insert('SLA_POLICIES', $SLA_POLICY);
			echo true;
		} else {
			echo false;
		}
	}
	function UPDATE_POLICY()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$PARAMS = array(
				'NAME' =>  $this->input->post('NAME'),
				'DESCRIPTION' => $this->input->post('DESCRIPTION'),
				'TRIGGER' =>  $this->input->post('TRIGGER'),
				'VIOLATION_RULES' =>  $this->input->post('VIOLATION_RULES'),
				'TARGETS' =>  $this->input->post('TARGETS'),
				'UPDATED_DATE' =>  date('Y-m-d h:i:s'),
				'ACTIVE' =>  $this->input->post('ACTIVE'),
			);
			return $this->db->where('ID', $this->input->post('ID'))->update('SLA_POLICIES', $PARAMS);
		} else {
			echo json_encode(false);
		}
	}

	function GET_POLICY($ID)
	{
		$POLICY = $this->db->get_where('SLA_POLICIES', array('ID' => $ID))->row_array();
		$DATA_POLICY = array(
			'ID' => $POLICY['ID'],
			'NAME' => $POLICY['NAME'],
			'DESCRIPTION' => $POLICY['DESCRIPTION'],
			'TRIGGER' =>  json_decode($POLICY['TRIGGER'], true),
			'VIOLATION_RULES' =>  json_decode($POLICY['VIOLATION_RULES'], true),
			'TARGETS' => $POLICY['TARGETS'],
			'TARGETS' => json_decode($POLICY['TARGETS'], true),
			'CREATED_DATE' => $POLICY['CREATED_DATE'],
			'UPDATED_DATE' => $POLICY['UPDATED_DATE'],
			'ACTIVE' => $POLICY['ACTIVE'] == 'true' ? true : false,
		);
		echo json_encode($DATA_POLICY);
	}

	function GET_LATEST_LOGS()
	{
		if ($_SESSION["ADMIN"] == 'false' && $_SESSION["STAFF"] == 'false') {
			if (is_null($_SESSION['CLIENT_ID'])) {
				$CLIENT = $_SESSION['TOKEN'];
			} else {
				$CLIENT = $_SESSION['CLIENT_ID'];
			}
			$LATEST_LOGS = $this->db->limit(100)->order_by("ID", "desc")->get_where('LOGS', array('CLIENT' => $CLIENT))->result_array();
			$DATA_LATEST_LOGS = array();
			foreach ($LATEST_LOGS as $LOG) {
				$USER = $this->db->get_where('USERS', array('ID' => $LOG['USER_ID']))->row_array();
				$DATA_LATEST_LOGS[] = array(
					'ID' => (int) $LOG['ID'],
					'DATE' => date(DATE_ISO8601, strtotime($LOG['DATE'])),
					'DETAIL' => $LOG['DETAIL'],
					'USER' => $USER['NAME']
				);
			};
			echo json_encode($DATA_LATEST_LOGS);
		} else {
			$LATEST_LOGS = $this->db->limit(100)->order_by("ID", "desc")->get('LOGS')->result_array();
			$DATA_LATEST_LOGS = array();
			foreach ($LATEST_LOGS as $LOG) {
				$USER = $this->db->get_where('USERS', array('ID' => $LOG['USER_ID']))->row_array();
				$DATA_LATEST_LOGS[] = array(
					'ID' => (int) $LOG['ID'],
					'DATE' => date(DATE_ISO8601, strtotime($LOG['DATE'])),
					'DETAIL' => $LOG['DETAIL'],
					'USER' => $USER['NAME']
				);
			};
			echo json_encode($DATA_LATEST_LOGS);
		}
	}

	function GET_PROCESSES()
	{
		$PROCESSES = $this->db->select('*')->get('PROCESSES')->result_array();
		echo json_encode($PROCESSES);
	}

	function GET_ARTICLE_CATEGORIES()
	{
		$ARTICLE_CATEGORIES = $this->db->select('*')->get('ARTICLE_CATEGORIES')->result_array();
		echo json_encode($ARTICLE_CATEGORIES);
	}

	function GET_ALL_ARTICLES()
	{
		$POST_DATA = file_get_contents("php://input");
		$COMING_DATA['REQUEST'] = json_decode($POST_DATA);
		$KEYWORD = $COMING_DATA['REQUEST']->FILTER->{'KEYWORD'};
		$COMING_DATA['REQUEST']->OFFSET = $COMING_DATA['REQUEST']->OFFSET - 1;
		if ($COMING_DATA['REQUEST']->OFFSET < 0) {
			$COMING_DATA['REQUEST']->OFFSET = 0;
		}
		$FROM = $COMING_DATA['REQUEST']->OFFSET * $COMING_DATA['REQUEST']->LIMIT;
		$RESPONSE = array();
		## Total number of RECORDS without filtering
		$this->db->select('count(*) as allcount');
		$RECORDS = $this->db->get('ARTICLES')->result();
		// Total Records Filters
		$TOTAL_RECORDS = $RECORDS[0]->allcount;
		if ($KEYWORD != '') {
			$this->db->like('TITLE', $KEYWORD);
			$this->db->or_like('CONTENT', $KEYWORD);
			$this->db->or_like('KEYWORDS', $KEYWORD);
		}
		// Total Records Filters
		## Total number of record with filtering
		$this->db->select('count(*) as allcount');
		$RECORDS = $this->db->get('ARTICLES')->result();
		$TOTAL_RECORD_WITH_FILTER = $RECORDS[0]->allcount;
		## Fetch RECORDS
		$this->db->select('*');
		$this->db->order_by('ARTICLES.ID', 'asc');
		$this->db->limit($COMING_DATA['REQUEST']->LIMIT, $FROM);
		//  Records Filters
		if ($KEYWORD != '') {
			$this->db->like('TITLE', $KEYWORD);
			$this->db->or_like('CONTENT', $KEYWORD);
			$this->db->or_like('KEYWORDS', $KEYWORD);
		}
		//  Records Filters
		$RECORDS = $this->db->get('ARTICLES')->result_array();
		$ARTICLES_DATA = array();
		foreach ($RECORDS as $ARTICLE) {
			$CATEGORY = $this->db->select('*')->get_where('ARTICLE_CATEGORIES', array('ID' => $ARTICLE['CATEGORY']))->row_array();
			$ARTICLES_DATA[] = array(
				'ID' => $ARTICLE['ID'],
				'TITLE' => $ARTICLE['TITLE'],
				'DESCRIPTION' => $ARTICLE['DESCRIPTION'],
				'CONTENT' => $ARTICLE['CONTENT'],
				'CATEGORY' => $CATEGORY,
				'URL' => $ARTICLE['URL'],
				'TOTAL_UPVOTE' => $this->db->get_where('ARTICLE_VOTES', array('ARTICLE_ID' => $ARTICLE['ID'], 'VOTE' => 1))->num_rows(),
				'TOTAL_VOTES' => $this->db->get_where('ARTICLE_VOTES', array('ARTICLE_ID' => $ARTICLE['ID']))->num_rows(),
				'TOTAL_DOWNVOTE' => $this->db->get_where('ARTICLE_VOTES', array('ARTICLE_ID' => $ARTICLE['ID'], 'VOTE' => 0))->num_rows(),
				'DATE' => date(DATE_ISO8601, strtotime($ARTICLE['DATE'])),
			);
		};
		$RESPONSE = array(
			"ALL_TOTAL" => $TOTAL_RECORDS,
			"TOTAL" => $TOTAL_RECORD_WITH_FILTER,
			"ARTICLES" => $ARTICLES_DATA
		);

		echo json_encode($RESPONSE);
	}

	function GET_ARTICLE($ID)
	{
		$ARTICLE = $this->db->get_where('ARTICLES', array('ID' => $ID))->row_array();
		$DATA_ARTICLE = array(
			'ID' => $ARTICLE['ID'],
			'TITLE' => $ARTICLE['TITLE'],
			'URL' => $ARTICLE['URL'],
			'CONTENT' => $ARTICLE['CONTENT'],
			'AUTHOR' => $this->GET_USER($ARTICLE['AUTHOR']),
			'DESCRIPTION' => $ARTICLE['DESCRIPTION'],
			'KEYWORDS' => json_decode($ARTICLE['KEYWORDS']),
			'CATEGORY' => json_decode($ARTICLE['CATEGORY'], true),
		);
		echo json_encode($DATA_ARTICLE);
	}

	function ADD_NEW_ARTICLE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$SLUG = url_title(convert_accented_characters($this->input->post('TITLE')), "-", TRUE);
			$PARAMS = array(
				'TITLE' => $this->input->post('TITLE'),
				'URL' => $SLUG,
				'AUTHOR' => $_SESSION['USER_ID'],
				'CONTENT' => $this->input->post('CONTENT'),
				'KEYWORDS' => $this->input->post('KEYWORDS'),
				'DESCRIPTION' => $this->input->post('DESCRIPTION'),
				'CATEGORY' => $this->input->post('CATEGORY'),
			);
			$this->db->insert('ARTICLES', $PARAMS);
			echo json_encode($this->db->insert_id());
		} else {
			echo json_encode(false);
		}
	}

	function UPDATE_ARTICLE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$SLUG = url_title(convert_accented_characters($this->input->post('TITLE')), "-", TRUE);
			$PARAMS = array(
				'TITLE' => $this->input->post('TITLE'),
				'URL' => $SLUG,
				'AUTHOR' => $_SESSION['USER_ID'],
				'CONTENT' => $this->input->post('CONTENT',FALSE),
				'KEYWORDS' => $this->input->post('KEYWORDS'),
				'DESCRIPTION' => $this->input->post('DESCRIPTION'),
				'CATEGORY' => $this->input->post('CATEGORY'),
			);
			$RESULT = $this->db->where('ID', $this->input->post('ID'))->update('ARTICLES', $PARAMS);
			if ($RESULT) {
				echo json_encode('true');
			} else {
				echo json_encode('false');
			}
		} else {
			echo json_encode('false');
		}
	}

	function REMOVE_ARTICLE()
	{
		if (isset($_POST) && count($_POST) > 0) {
			$this->db->delete('ARTICLES', array('ID' => $this->input->post('ID')));
			echo json_encode(true);
		} else {
			echo json_encode(false);
		}
	}

	public function GET_EMAIL_OPTIONS()
	{
		if ($_SESSION['ADMIN'] == 'true') {
			$OPTIONS = $this->db->get_where('OPTIONS', array('NAME' => 'APP'))->row_array();
			echo json_encode($OPTIONS);
		} else {
			echo json_encode(false);
		}
	}
}
