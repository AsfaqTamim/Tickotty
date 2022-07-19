<?php
defined('BASEPATH') or exit('No direct script access allowed');
class USER extends CI_Model
{

  function __construct()
  {
    parent::__construct();
    $this->load->database();
  }

  function CREATE_USER($USERNAME, $EMAIL, $PASSWORD, $NAME, $SURNAME)
  {
    $data = array(
      'USERNAME' => $USERNAME,
      'EMAIL' => $EMAIL,
      'PASSWORD' => $this->hash_password($PASSWORD),
	  'NAME' => $NAME,
	  'SURNAME' => $SURNAME,
    );
    return $this->db->insert('USERS', $data);
  }

  function sifre_degistir($USERNAME, $password)
  {
    $this->db->where('USERNAME', $USERNAME);
    return $response = $this->db->update('USERS', array('password' => $this->hash_password($password)));
  }

  function RESOLVE_USER_LOGIN_BY_EMAIL($EMAIL, $PASSWORD)
  {
    $this->db->select('PASSWORD');
    $this->db->from('USERS');
    $this->db->where('EMAIL', $EMAIL);
    $HASH = $this->db->get()->row('PASSWORD');
    return $this->verify_password_hash($PASSWORD, $HASH);
  }

  function RESOLVE_USER_LOGIN($USERNAME, $PASSWORD)
  {
    $this->db->select('PASSWORD');
    $this->db->from('USERS');
    $this->db->where('USERNAME', $USERNAME);
    $HASH = $this->db->get()->row('PASSWORD');
    return $this->verify_password_hash($PASSWORD, $HASH);
  }

  function GET_USER_ID_FROM_USERNAME($USERNAME)
  {
    $this->db->select('ID');
    $this->db->from('USERS');
    $this->db->where('USERNAME', $USERNAME);
    return $this->db->get()->row('ID');
  }

  function GET_USER_ID_FROM_EMAIL($EMAIL)
  {
    $this->db->select('ID');
    $this->db->from('USERS');
    $this->db->where('EMAIL', $EMAIL);
    return $this->db->get()->row('ID');
  }

  function GET_USER_FROM_USERNAME($USERNAME)
  {
    return $this->db->get_where('USERS', array('USERNAME' => $USERNAME))->row_array();
  }

  function GET_USER($ID)
  {
    $this->db->from('USERS');
    $this->db->where('ID', $ID);
    return $this->db->get()->row();
  }

  function GET_USER_BY_EMAIL($email)
  {
    $q = $this->db->get_where('USERS', array('EMAIL' => $email), 1);
    if ($this->db->affected_rows() > 0) {
      $row = $q->row();
      return $row;
    } else {
      error_log('no user found getUserInfo(' . $email . ')');
      return false;
    }
  }

  public function INSERT_TOKEN($USER_ID)
  {
    $token = substr(sha1(rand()), 0, 30);
    $date = date('Y-m-d');

    $string = array(
      'TOKEN' => $token,
      'USER_ID' => $USER_ID,
      'DATE' => $date
    );
    $query = $this->db->insert_string('TOKENS', $string);
    $this->db->query($query);
    return $token . $USER_ID;
  }

  public function isTokenValid($token)
  {
    $tkn = substr($token, 0, 30);
    $uid = substr($token, 30);

    $q = $this->db->get_where('TOKENS', array(
      'TOKENS.TOKEN' => $tkn,
      'TOKENS.USER_ID' => $uid
    ), 1);

    if ($this->db->affected_rows() > 0) {
      $row = $q->row();

      $created = $row->DATE;
      $createdTS = strtotime($created);
      $today = date('Y-m-d');
      $todayTS = strtotime($today);

      if ($createdTS != $todayTS) {
        return false;
      }

      $user_info = $this->getUserInfo($row->USER_ID);
      return $user_info;
    } else {
      return false;
    }
  }

  public function getUserInfo($id)
  {
    $q = $this->db->get_where('USERS', array('ID' => $id), 1);
    if ($this->db->affected_rows() > 0) {
      $row = $q->row();
      return $row;
    } else {
      error_log('no user found getUserInfo(' . $id . ')');
      return false;
    }
  }

  function updatePassword($post)
  {
    $this->db->where('ID', $post['USER_ID']);
    $this->db->update('USERS', array('PASSWORD' => $this->hash_password($post['PASSWORD'])));
    $success = $this->db->affected_rows();
    if (!$success) {
      error_log('Unable to updatePassword(' . $post['USER_ID'] . ')');
      return false;
    }
    return true;
  }

  private
  function hash_password($password)
  {
    return password_hash($password, PASSWORD_BCRYPT);
  }

  private

  function verify_password_hash($password, $hash)
  {
    return password_verify($password, $hash);
  }
}
