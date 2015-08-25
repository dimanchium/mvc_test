<?php

class Router {

    protected $action;

    public function getIp() {
        return getenv('HTTP_CLIENT_IP')? :
                getenv('HTTP_X_FORWARDED_FOR')? :
                        getenv('HTTP_X_FORWARDED')? :
                                getenv('HTTP_FORWARDED_FOR')? :
                                        getenv('HTTP_FORWARDED')? :
                                                getenv('REMOTE_ADDR');
    }

    public function getAction() {
        if (isset($_GET["action"]) && is_string($_GET["action"]))
            $this->action = htmlspecialchars($_GET["action"], ENT_QUOTES, 'UTF-8');
        return $this->action;
    }

    public function getVariable($var) {
        if (is_array($_GET[$var])) {
            return array_map($this->getVariable, $_GET[$var]);
        } else {
            if ($_GET[$var])
                return htmlspecialchars($_GET[$var], ENT_QUOTES, 'UTF-8');
            else
                return false;
        }
    }

    public function postVariable($var) {
        if (is_array($_POST[$var])) {
            return array_map($this->postVariable, $_POST[$var]);
        } else {
            if ($_POST[$var])
                return htmlspecialchars($_POST[$var], ENT_QUOTES, 'UTF-8');
            else
                return false;
        }
    }

    // проверка на аякс запрос
    function is_ajax() {
        return isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';
    }

}

?>
