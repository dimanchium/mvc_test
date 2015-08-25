<?php

/*
  Обработчик ajax-запросов
*/

require_once "../../define.php";
require_once "../../classes/database.class.php";
require_once "../../classes/router.class.php";
require_once "calendardata.class.php";

$router = new Router();
$calendardata = new Calendardata();

if ($router->is_ajax()) {
    $month = $router->postVariable("month");
    $year = $router->postVariable("year");

    switch ($router->postVariable("act")) {
        case "new":
            //массив месяцев
            $month = $calendardata->getMonthDatabyMonthandYear($month, $year);
            $month += $calendardata->getNextAndPreviousMonthIdByMonthId($month["id"]);
            //массив лет
            $year = $calendardata->getYearDatabyYear($year);
            $year += $calendardata->getNextAndPreviousYearIdByYearId($year["id"]);

            $days = $calendardata->getDaysByMonthId($month["id"]);
            $calendardata->addNumOfWeek($days);
            break;

        case "next_month":
        case "prev_month":
            //массив месяцев
            $month = $calendardata->getMonthDatabyMonthId($month);
            $month += $calendardata->getNextAndPreviousMonthIdByMonthId($month["id"]);
            //массив лет
            $year = $calendardata->getYearDatabyYearId($year);
            $year += $calendardata->getNextAndPreviousYearIdByYearId($year["id"]);
            break;

        case "next_year":
        case "prev_year":
            //массив месяцев
            $month = $calendardata->getMonthDataByMonthNumAndYearId($month, $year);
            $month += $calendardata->getNextAndPreviousMonthIdByMonthId($month["id"]);
            //массив лет
            $year = $calendardata->getYearDatabyYearId($year);
            $year += $calendardata->getNextAndPreviousYearIdByYearId($year["id"]);
            break;

        case "update_days":
            $days = $router->postVariable("days");            
            $calendardata->updateDays($days);
            break;
    }

    $days = $calendardata->getDaysByMonthId($month["id"]);
    $calendardata->addNumOfWeek($days);

    echo json_encode(array("month" => $month, "year" => $year, "days" => $days));
}

?>
