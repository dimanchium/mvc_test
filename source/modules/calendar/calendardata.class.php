<?php

class Calendardata extends Database {

    //
    // Получение данных о месяце по id месяца  
    //
    
    public function getMonthDatabyMonthId($month_id) {
        return $this->getRow(
                        "SELECT month_id as id, lu_month.month_of_year_id as num,
                            month_duration as duration, month_of_year_desc as name FROM lu_month
                            INNER JOIN lu_month_of_year ON lu_month_of_year.month_of_year_id = lu_month.month_of_year_id
                            WHERE lu_month.month_id = ?", array($month_id)
	);
    }

    //
    // Получение данных о месяце по месяцу и году 
    //
        
    public function getMonthDatabyMonthandYear($month, $year) {
        return $this->getRow(
                        "SELECT month_id as id, lu_month.month_of_year_id as num,
                            month_duration as duration, month_of_year_desc as name FROM lu_month
                            INNER JOIN lu_quarter ON lu_quarter.quarter_id = lu_month.quarter_id
                            INNER JOIN lu_year ON lu_year.year_id = lu_quarter.year_id
                            INNER JOIN lu_month_of_year ON lu_month_of_year.month_of_year_id = lu_month.month_of_year_id
                            WHERE lu_month.month_of_year_id = ? AND year_desc = ?", array($month, $year)
	);
    }

    //
    // Получение id следующего и предыдущего месяца по id текущего  
    //
           
    public function getNextAndPreviousMonthIdByMonthId($month_id) {
        return (array) $this->getRow("SELECT month_id as next_id FROM lu_month WHERE prev_month_id = ?", array($month_id))
                + (array) $this->getRow("SELECT prev_month_id as prev_id FROM lu_month WHERE month_id = ?", array($month_id)
	);
    }

    //
    // Получение данных о годе по году 
    //
        
    public function getYearDatabyYear($year) {
        //информация о годе (id года, продолжительность года)
        return $this->getRow(
                        "SELECT year_id as id, year_duration as duration, year_desc as name FROM lu_year
                            WHERE year_desc = ?", array($year)
	);
    }

    //
    // Получение данных о годе по id года 
    //
        
    public function getYearDatabyYearId($year_id) {
        //информация о годе (id года, продолжительность года)
        return $this->getRow(
                        "SELECT year_id as id, year_duration as duration, year_desc as name FROM lu_year
                            WHERE year_id = ?", array($year_id));
    }

    //
    // Получение id следующего и предыдущего года по id текущего  
    //
                  
    public function getNextAndPreviousYearIdByYearId($year_id) {
        return (array) $this->getRow("SELECT year_id as next_id FROM lu_year WHERE prev_year_id = ?", array($year_id))
                + (array) $this->getRow("SELECT prev_year_id as prev_id FROM lu_year WHERE year_id = ?", array($year_id)
	);
    }

    //
    // Получение данных месяца по его номеру и по id года   
    //
           
    public function getMonthDataByMonthNumAndYearId($month_num, $year_id) {
        return $this->getRow(
                        "SELECT month_id as id, lu_month.month_of_year_id as num,
                            month_duration as duration, month_of_year_desc as name FROM lu_month
                            INNER JOIN lu_quarter ON lu_quarter.quarter_id = lu_month.quarter_id
                            INNER JOIN lu_year ON lu_year.year_id = lu_quarter.year_id
                            INNER JOIN lu_month_of_year ON lu_month_of_year.month_of_year_id = lu_month.month_of_year_id
                            WHERE lu_month.month_of_year_id = ? AND lu_year.year_id = ?", array($month_num, $year_id)
	);
    }

    //
    // Получение дней по id месяца   
    //
        
    public function getDaysByMonthId($month_id) {
        return $this->getRows(
                        "SELECT day_id as id, day_desc as name, day_of_week_id as day_of_week, holiday_ind, day_of_month, day_of_year 
                            FROM lu_day WHERE month_id = ? ORDER BY day_of_month", array($month_id)
	);
    }

    // 
    // Обновление данных о днях
    //
        
    public function updateDays($days) {
        foreach ($days as $day) {
        	$this->setRows(
                	"UPDATE lu_day SET holiday_ind = ? WHERE day_id = ? AND day_desc = ?", array($day["holiday_ind"], $day["id"], $day["name"])
		);
        }
    }

    //
    // Добавление массива номеров недель
    //
        
    public function addNumOfWeek(&$days) {
        $week_counter = 1;
        foreach ($days as &$day) {
            if ($day["day_of_week"] == 1 && $day["day_of_month"] != 1)
                $week_counter++;
            $day["num_of_week"] = $week_counter;
        }
    }

}

?>
