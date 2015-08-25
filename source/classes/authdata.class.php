<?php

class Authdata extends Database {

    public function isBanned($ip, $time) {
        return $this->getRow(
		"SELECT * FROM ban WHERE ip = ? AND ? BETWEEN time_start AND time_end", array($ip, $time)
	);
    }

    public function getEndBan($ip) {
        $array = $this->getRow(
		"SELECT time_end FROM ban WHERE ip = ? ORDER BY time_end DESC", array($ip)
	);
        return $array["time_end"];
    }

    public function isUser($user, $pass) {
        return $this->getRow(
		"SELECT * FROM person WHERE TRIM(username) = ? AND pass = ?", array($user, $pass)
	);
    }

    public function banIp($ip, $time_start, $time_end) {
        return $this->setRows(
		"INSERT into ban VALUES (?, ?, ?)", array($ip, $time_start, $time_end)
	);
    }

    //функция для проверки доступности модуля
    public function actionGranted($action, $modules) {
        foreach ($modules as $module) {
            if ($module["action"] == $action)
                return true;
        }
        return false;
    }

}

?>
