<?php
defined('BASEPATH') or exit('No direct script access allowed');
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Methods: GET, OPTIONS");
date_default_timezone_set('Europe/Istanbul');
class Cron extends CronJOB
{
	function index()
	{
		$SLA_POLICIES = $this->db->get_where('SLA_POLICIES')->result_array();
		foreach ($SLA_POLICIES as $POLICY) {
			$TICKETS = $this->db->get_where('TICKETS', array('SLA_POLICY' => $POLICY['ID']))->result_array();
			foreach ($TICKETS as $TICKET) {
				$RESPONSE = GET_FIRST_ROW('CONVERSATIONS', array('RELATION_TYPE' => 'TICKET', 'RELATED_ID' => $TICKET['ID']));
				if (SLA_VIOLATED(1, $TICKET['ID'])) {
					$RESPONSE_DATE = SLA_VIOLATED(1, $TICKET['ID'])['DATE'];
				} else {
					if ($RESPONSE) {
						$RESPONSE_DATE = $RESPONSE['DATE'];
					} else {
						$RESPONSE_DATE = date("Y-m-d H:i:s");
					}
				}
				if (SLA_VIOLATED(2, $TICKET['ID'])) {
					$RESOLVE_DATE = SLA_VIOLATED(2, $TICKET['ID'])['DATE'];
				} else {
					if ($TICKET['STATUS'] != 4) {
						$RESOLVE_DATE = date("Y-m-d H:i:s");
					} else {
						$RESOLVE_DATE = $TICKET['CLOSED_DATE'];
					}
				}
				if ($TICKET['SLA_POLICY']) {
					$SLA_POLICY = $this->db->get_where('SLA_POLICIES', array('ID' => $TICKET['SLA_POLICY']))->row_array();
					$POLICY_DATA =  json_decode($SLA_POLICY['TARGETS'], true);
					$POLICY = array();
					foreach ($POLICY_DATA as $POLICY_IN) {
						if ($POLICY_IN['ID'] == $TICKET['PRIORITY']) {
							$POLICY = $POLICY_IN;
						}
					}
					$SLA_TYPES = $POLICY['DATA'];
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
					$SLA_RESPOND_STAMP = CALCULATE_DUE_BY_PERIOD($SLA_RESPOND['PERIOD'], $SLA_RESPOND['TIME'], $TICKET['CREATED_DATE']);
					$SLA_RESOLVE_STAMP = CALCULATE_DUE_BY_PERIOD($SLA_RESOLVE['PERIOD'], $SLA_RESOLVE['TIME'], $TICKET['CREATED_DATE']);
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
					//In this line, we insert the violated tickets into the database.
					if (date("Y-m-d H:i:s") > $SLA_RESPOND_STAMP && !$RESPONSE && !SLA_VIOLATED(1, $TICKET['ID'])) {
						$RESPOND_VIOLATED = true;
						//Person will be notified
						$PERSON_WILL_BE_NOTIFIED = array();
						foreach ($VIOLATION_RESPONSE['INFORM'] as $PERSON) {
							array_push($PERSON_WILL_BE_NOTIFIED, $PERSON['ID']);
						}
						if (!empty($TICKET['ASSIGNED_ID'] && $VIOLATION_RESPONSE['WARN_ASSIGNED'])) {
							if (!in_array($TICKET['ASSIGNED_ID'], $PERSON_WILL_BE_NOTIFIED)) {
								array_push($PERSON_WILL_BE_NOTIFIED, $TICKET['ASSIGNED_ID']);
							}
						}
						$this->db->insert('SLA_VIOLATIONS', array(
							'SLA_POLICY' => $SLA_POLICY['ID'],
							'VIOLATION_TYPE' => 1,
							'WARNED' => 'false',
							'TICKET_ID' => $TICKET['ID'],
							'TICKET_TOKEN' => $TICKET['TOKEN'],
							'ALERT_DATE' => $VIOLATION_RESPOND_ALERT_DATE,
							'PERSON_WILL_BE_NOTIFIED' => json_encode($PERSON_WILL_BE_NOTIFIED),
						));
					} else {
						$RESPOND_VIOLATED = 'false';
					}
					if (date("Y-m-d H:i:s") > $SLA_RESOLVE_STAMP && $TICKET['STATUS'] != 4 && !SLA_VIOLATED(2, $TICKET['ID'])) {
						$RESOLVE_VIOLATED = true;
						//Person will be notified
						$PERSON_WILL_BE_NOTIFIED = array();
						foreach ($VIOLATION_RESOLVE['INFORM'] as $PERSON) {
							array_push($PERSON_WILL_BE_NOTIFIED, $PERSON['ID']);
						}
						if (!empty($TICKET['ASSIGNED_ID'] && $VIOLATION_RESOLVE['WARN_ASSIGNED'])) {
							if (!in_array($TICKET['ASSIGNED_ID'], $PERSON_WILL_BE_NOTIFIED)) {
								array_push($PERSON_WILL_BE_NOTIFIED, $TICKET['ASSIGNED_ID']);
							}
						}
						$this->db->insert('SLA_VIOLATIONS', array(
							'SLA_POLICY' => $SLA_POLICY['ID'],
							'VIOLATION_TYPE' => 2,
							'WARNED' => 'false',
							'TICKET_ID' => $TICKET['ID'],
							'TICKET_TOKEN' => $TICKET['TOKEN'],
							'ALERT_DATE' => $VIOLATION_RESOLVE_ALERT_DATE,
							'PERSON_WILL_BE_NOTIFIED' => json_encode($PERSON_WILL_BE_NOTIFIED),
						));
					} else {
						$RESOLVE_VIOLATED = false;
					}
					$RESPOND_DURATION = date_diff(date_create($SLA_RESPOND_STAMP), date_create($RESPONSE_DATE));
					$RESOLVE_DURATION = date_diff(date_create($SLA_RESOLVE_STAMP), date_create($RESOLVE_DATE));
					$TICKETS_RESULT[] =  array(
						'TICKET_ID' => $TICKET['ID'],
						'RESPOND' => array(
							'DUE' => date(DATE_ISO8601, strtotime($SLA_RESPOND_STAMP)),
							'ALERT_DATE' => date("Y-m-d H:i:s"),
							'REPLIED' => $RESPONSE,
							'ALERT_DATE' => date(DATE_ISO8601, strtotime($VIOLATION_RESPOND_ALERT_DATE)),
							'WARN_ASSIGNED'  => $VIOLATION_RESPONSE['WARN_ASSIGNED'],
							'ASSIGNED' => $this->GET_USER($TICKET['ASSIGNED_ID']),
							'VIOLATED' => $RESPOND_VIOLATED,
							'NOTIFIED' => false,
							'DURATION' =>  $RESPOND_DURATION,
						),
						'RESOLVE' => array(
							'DUE' => date(DATE_ISO8601, strtotime($SLA_RESOLVE_STAMP)),
							'ALERT_DATE' => date(DATE_ISO8601, strtotime($VIOLATION_RESOLVE_ALERT_DATE)),
							'WARN_ASSIGNED'  => $VIOLATION_RESOLVE['WARN_ASSIGNED'],
							'ASSIGNED' => $this->GET_USER($TICKET['ASSIGNED_ID']),
							'VIOLATED' => $RESOLVE_VIOLATED,
							'NOTIFIED' => false,
							'DURATION' =>  $RESOLVE_DURATION,
						),
					);
				}
			}
		}

		$VIOLATIONS = $this->db->get_where('SLA_VIOLATIONS', array('WARNED' => 'false'))->result_array();
		if ($VIOLATIONS) {
			foreach ($VIOLATIONS as $VIOLATION) {
				if (date('Ymd hi') == date('Ymd hi', strtotime($VIOLATION['ALERT_DATE']))) {
					$PERSON_WILL_BE_NOTIFIED =  json_decode($VIOLATION['PERSON_WILL_BE_NOTIFIED'], true);
					foreach ($PERSON_WILL_BE_NOTIFIED as $PERSON) {
						$this->db->insert('NOTIFICATIONS', array(
							'TITLE' => 'New Violation',
							'RECEIVER' => $PERSON,
							'RELATION_TYPE' => 'TICKET',
							'RELATED_ID' => 1,
							'DETAIL' => '<a ng-href="#!/tickets/ticket/' . $VIOLATION['TICKET_TOKEN'] . '" class="notification-target-link">#' . $VIOLATION['TICKET_TOKEN'] . '</a> has been violated!'
						));
						$this->db->where('ID', $VIOLATION['ID'])->update('SLA_VIOLATIONS', array('WARNED' => 'true'));
					}
				}
				$VIOLATIONS_RESULT[] =  array(
					'ID' => $VIOLATION['ID'],
				);
			}
		} else {
			$VIOLATIONS_RESULT = [];
		}

		echo json_encode(array(
			'TICKETS' => $TICKETS_RESULT,
			'VIOLATIONS' => $VIOLATIONS_RESULT,
		));
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
};