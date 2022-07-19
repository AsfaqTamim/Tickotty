<?php
defined('BASEPATH') or exit('No direct script access allowed');
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Methods: GET, OPTIONS");
date_default_timezone_set('Europe/Istanbul');
class Home extends HomeCTRL
{
    function GET_ALL_ARTICLES()
    {
        $ALL_NEWS = $this->db->select('*')->order_by('DATE', "DESC")->get_where('ARTICLES', array())->result_array();
        $DATA_ALL_NEWS = array();
        foreach ($ALL_NEWS as $NEWS) {
            $DATA_ALL_NEWS[] = array(
                'ID' => $NEWS['ID'],
                'TITLE' => $NEWS['TITLE'],
                'DESCRIPTION' => $NEWS['DESCRIPTION'],
                'CONTENT' => $NEWS['CONTENT'],
                'PHOTO' => $NEWS['PHOTO'],
                'URL' => $NEWS['URL'],
                'DATE' => date(DATE_ISO8601, strtotime($NEWS['DATE'])),
            );
        };
        echo json_encode($DATA_ALL_NEWS);
    }

    function GET_ARTICLE_CATEGORIES()
    {
        $ARTICLE_CATEGORIES = $this->db->select('*')->get('ARTICLE_CATEGORIES')->result_array();
        if ($ARTICLE_CATEGORIES) {
            foreach ($ARTICLE_CATEGORIES as $CATEGORY) {
                $ALL_ARTICLES = $this->db->select('*')->order_by('DATE', "DESC")->get_where('ARTICLES', array('CATEGORY' => $CATEGORY['ID']))->result_array();
                $DATA_ALL_ARTICLES = array();
                foreach ($ALL_ARTICLES as $ARTICLE) {
                    $DATA_ALL_ARTICLES[] = array(
                        'ID' => $ARTICLE['ID'],
                        'TITLE' => $ARTICLE['TITLE'],
                        'DESCRIPTION' => $ARTICLE['DESCRIPTION'],
                        'CONTENT' => $ARTICLE['CONTENT'],
                        'URL' => $ARTICLE['URL'],
                        'DATE' => date(DATE_ISO8601, strtotime($ARTICLE['DATE'])),
                    );
                };
                $DATA_CATEGORIES[] = array(
                    'ID' => $CATEGORY['ID'],
                    'CATEGORY_URL' => $CATEGORY['CATEGORY_URL'],
                    'NAME' => $CATEGORY['NAME'],
                    'PARENT' => $CATEGORY['PARENT'],
                    'ARTICLES' => $DATA_ALL_ARTICLES,

                );
            };
        } else {
            return null;
        }

        echo json_encode($DATA_CATEGORIES);
    }

    function GET_CATEGORY_ARTICLES($ID)
    {
        $ALL_ARTICLES = $this->db->select('*')->order_by('DATE', "DESC")->get_where('ARTICLES', array('CATEGORY' => $ID))->result_array();
        $DATA_ALL_ARTICLES = array();
        foreach ($ALL_ARTICLES as $ARTICLE) {
            $DATA_ALL_ARTICLES[] = array(
                'ID' => $ARTICLE['ID'],
                'TITLE' => $ARTICLE['TITLE'],
                'DESCRIPTION' => $ARTICLE['DESCRIPTION'],
                'CONTENT' => $ARTICLE['CONTENT'],
                'URL' => $ARTICLE['URL'],
                'DATE' => date(DATE_ISO8601, strtotime($ARTICLE['DATE'])),
            );
        };

        echo json_encode($DATA_ALL_ARTICLES);
    }

    function GET_ARTICLE($SLUG)
    {
        $ARTICLE = $this->db->select('*')->get_where('ARTICLES', array('URL' => $SLUG))->row_array();
        $CATEGORY = $this->db->select('*')->get_where('ARTICLE_CATEGORIES', array('ID' => $ARTICLE['CATEGORY']))->row_array();
        //VOTING
        if (isset($_SESSION['LOGGED_IN'])) {
            $HAS_VOTE = $this->db->get_where('ARTICLE_VOTES', array('ARTICLE_ID' => $ARTICLE['ID'], 'USER_ID' => $_SESSION['USER_ID']))->num_rows();
            if ($HAS_VOTE) {
                $CAN_VOTE = false;
            } else {
                $CAN_VOTE = true;
            }
        } else {
            $CAN_VOTE = true;
        }
        $DATA_ALL_ARTICLE = array(
            'ID' => $ARTICLE['ID'],
            'TITLE' => $ARTICLE['TITLE'],
            'DESCRIPTION' => $ARTICLE['DESCRIPTION'],
            'CATEGORY' => $CATEGORY,
            'CONTENT' => $ARTICLE['CONTENT'],false,
            'AUTHOR' => $this->GET_USER($ARTICLE['AUTHOR']),
            'URL' => $ARTICLE['URL'],
            'DATE' => date(DATE_ISO8601, strtotime($ARTICLE['DATE'])),
            'CAN_VOTE' => $CAN_VOTE,
            'TOTAL_VOTES' => $this->db->get_where('ARTICLE_VOTES', array('ARTICLE_ID' => $ARTICLE['ID']))->num_rows(),
            'TOTAL_UPVOTE' => $this->db->get_where('ARTICLE_VOTES', array('ARTICLE_ID' => $ARTICLE['ID'], 'VOTE' => 1))->num_rows(),
        );
        echo json_encode($DATA_ALL_ARTICLE);
    }

    function SEARCH_ARTICLE()
    {
        if (isset($_POST) && count($_POST) > 0) {
            if ($_POST['KEY'] != '') {
                $this->db->like('TITLE', $_POST['KEY']);
                $this->db->or_like('CONTENT', $_POST['KEY']);
                $this->db->or_like('KEYWORDS', $_POST['KEY']);
                $QUERY = $this->db->get('ARTICLES');
                $RESULT =  $QUERY->result();
                echo json_encode($RESULT);
            } else {
                echo null;
            }
        }
    }

    function VOTE_ARTICLE()
    {
        if (isset($_POST) && count($_POST) > 0) {
            if (isset($_SESSION['LOGGED_IN'])) {
                $HAS_VOTE = $this->db->get_where('ARTICLE_VOTES', array('ARTICLE_ID' => $this->input->post('ID'), 'USER_ID' => $_SESSION['USER_ID']))->num_rows();
                if ($HAS_VOTE) {
                    echo 'false';
                } else {
                    $VOTE = array(
                        'USER_ID' => $_SESSION['LOGGED_IN'],
                        'ARTICLE_ID' => $this->input->post('ID'),
                        'VOTE' => $this->input->post('VOTE'),
                    );
                    $this->db->insert('ARTICLE_VOTES', $VOTE);
                    echo 'true';
                }
            } else {
                echo 'false';
            }
        } else {
            echo 'false';
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
};
