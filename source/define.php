<?php

        //название системы
        define("SITE_NAME", "Тестовая система");

	//путь к системе относительно корня веб-сервера
	define("SITE_ROOT", "mvc_test");

	//настройки БД
	define("DB_TYPE", "pgsql");
	define("DB_HOST", "localhost");
	define("DB_NAME", "mvc_test");
	define("DB_USER", "pg_user");
	define("DB_PASS", "pg_pass");
        
	//время хранения сессии
	define("SESSION_MAXLIFETIME", 10800);
        
        //время в бане
	define("BAN_TIME", 10800);
        
        //количество неверных попыток зайти под пользователем до бана
        define("BAN_ATTEMPTS", 10);
        
        //заголовок и содержимое при отсутствии модулей
        define("NO_MODULES_TITLE", "Ошибка");
        define("NO_MODULES_CONTENT", "<div style='text-align: center'>К сожалению для данного пользователя нет доступных модулей</div>");
                

?>
