<?php

class Maindata extends Database {

    public function getModulesByAuthdata($user, $pass) {
        return $this->getRows(
            "SELECT module_id as id, module_title as title, module_action as action FROM auth_module
		");
    }

    public function getModuleByAction($action) {
        return $this->getRow(
            "SELECT module_id as id, module_title as title, module_action as action FROM auth_module 
                WHERE module_action = ?", array($action));
    }

}

?>
