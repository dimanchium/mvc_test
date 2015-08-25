<?php

//константы
require_once("define.php");
//базовые классы
require_once("classes/router.class.php");
require_once("classes/database.class.php");
require_once("classes/view.class.php");
//классы для построения меню
require_once("classes/maindata.class.php");
require_once("classes/mainview.class.php");
//авторизация
require_once("classes/authdata.class.php");


$router = new Router();
$maindata = new Maindata();
$mainview = new Mainview();
$authdata = new Authdata();

//если забанен
if ($authdata->isBanned($router->getIp(), time())) {
    $mainview->setContent($mainview->template(dirname(__FILE__)."/templates/auth/ban.tmpl", array(
        "date" => date("G:i:s d/m/Y", $authdata->getEndBan($router->getIp()))
    )));
} else {
    //запускаю сессию
    ini_set('session.gc_maxlifetime', SESSION_MAXLIFETIME);
    session_start();
    if ($router->postVariable("auth_exit")) { list($_SESSION["user"], $_SESSION["pass"]) = array(false, false); }
    //если отправлял данные формы
    if ($router->postVariable("auth_validation")) {
        list($_SESSION["user"], $_SESSION["pass"]) = array($router->postVariable("auth_name"), $router->postVariable("auth_pass"));
    }
    //если прошёл авторизацию
    if ($authdata->isUser($_SESSION["user"], md5($_SESSION["pass"]))) {
        //обнуляю счётчик ошибок ввода данных
        $_SESSION["error_counter"] = 0;

        $modules = $maindata->getModulesByAuthdata($_SESSION["user"], md5($_SESSION["pass"]));
        
        $nav_menu = $mainview->navMenu($modules, $router->getAction());        
        
        if (!empty($modules)) {           
            if ($router->getAction() && $authdata->actionGranted($router->getAction(), $modules)) {
                $module = $maindata->getModuleByAction($router->getAction());
            } else {
		// модуль по умолчанию
                $module = $modules[0];
            }
            
            //подключаю файлы модуля
            require_once(dirname(__FILE__)."/modules/".$module["action"]."/index.php");
                       
        } else {
            $module["title"] = NO_MODULES_TITLE;
            $mainview->setContent(NO_MODULES_CONTENT);
        }

        $mainview->setContent($mainview->template(dirname(__FILE__)."/templates/page.tmpl", array(
            "user" => $_SESSION["user"],
            "title" => $module["title"]." - ".SITE_NAME,
            "nav_menu" => $nav_menu,
            "module_title" => $module["title"],
            "module_content" => $mainview->getContent(),
            "js_scripts" => $mainview->getJsScripts(),
            "styles" => $mainview->getStyles()
            
        )));  
    } else {
        if ($router->postVariable("auth_validation")) {
            $_SESSION["error_counter"] ? $_SESSION["error_counter"]++ : $_SESSION["error_counter"] = 1;
            //проверка на количество неправильных попыток ввода
            if ($_SESSION["error_counter"] < BAN_ATTEMPTS) {
                $mainview->setContent($mainview->template(dirname(__FILE__) . "/templates/auth/error.tmpl", array(
                    "title" => SITE_NAME    
                )));   
            } else {
                $authdata->banIp($router->getIp(), time(), (time() + BAN_TIME));
                $mainview->setContent($mainview->template(dirname(__FILE__) . "/templates/auth/ban.tmpl", array(
                    "date" => date("G:i:s d/m/Y", $authdata->getEndBan($router->getIp()))
                )));
            }
        } else {           
                $mainview->setContent($mainview->template(dirname(__FILE__) . "/templates/auth/form.tmpl", array(
                    "title" => SITE_NAME
                )));                        
        }
    }
}

$mainview->displayContent();

?>

