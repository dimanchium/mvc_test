/*
  js-скрипты для модуля "Производственный календарь"
*/

$.fn.extend({
    triggerClass: function(class1, class2, callback) 
    {       
        if (this.hasClass(class1)) 
        {
            this.removeClass(class1).addClass(class2);
                                
        } else if (this.hasClass(class2)) {
            this.removeClass(class2).addClass(class1);
        }
        callback;
    }
});


$(function(){
                           
    function Filler()
    {
        //private
        var act;
        var month;
        var year;
        var days = [];
        var upd_days = [];
        var self = this;
            
        function ajax(data_obj)
        {
            $.ajax({
                async:false,
                url: 'modules/calendar/handler.php', 
                type: 'post', 
                dataType: 'json', 
                data: data_obj, 
                success: function (data) {
                    setData(act, data["month"], data["year"], data["days"]);
                } 
            });     
        }
            
        function setData(act_new, month_new, year_new, days_new) 
        {      
            act = act_new;
            month = month_new; 
            year = year_new; 
            days = days_new;
        }
            
        function fillCalendarTable() 
        {      
            fillCalendarHeadTable();
            fillCalendarBodyTable();
        }
    
        function fillCalendarHeadTable ()
        {
            $("#month").text(month["name"]);
            $("#year").text(year["name"]);
        }
            
        function fillCalendarBodyTable ()
        {
            //сначала удаляю старое
            $("#calendar tbody").empty();            
            //нахожу пересечение массивов, чтобы при смене месяцев не исчезали временные изменения в календаре
            if (upd_days.length) {
                for (var i=0; i<upd_days.length; i++) {         
                    for (var j=0; j<days.length; j++) {    
                        if (upd_days[i]["id"] === days[j]["id"])
                        {
                            days[j]["holiday_ind"] = upd_days[i]["holiday_ind"];
			    days[j]["description"] = upd_days[i]["description"];
                        }       
                    }
                }
            }
            
            // номер первого дня месяца в таблице (первая неделя)
            var first_day_num_in_table = days[0]["day_of_week"];
            //количество недель
            var num_of_weeks = Math.ceil((days.length + first_day_num_in_table - 1) / 7);
                    
            for (var i=1; i<num_of_weeks*7+1; i++)
            {
                //номер недели в таблице
                var num_of_week = Math.ceil(i/7);

                if ((i-1)%7 == 0)
                {
                    $("#calendar tbody")
                    .append("<tr class='week'></tr>")
                    .data("num_of_week", num_of_week);
                }
                            
                $('#calendar tbody tr:nth-child(' + (num_of_week) +')')
                .append('<td></td>')
                .data("num_in_table", i + 1);
                           
            }
                                       
            $.each(days, function (index, value) {
                var day = value;
                $('#calendar tbody tr:nth-child(' + day["num_of_week"] + ') td:nth-child(' 
                    + (day["day_of_week"]) +')')
                .append(day["day_of_month"] + '<img src="img/calendar/edit.png" style="position:absolute; right:0; bottom:0;">')
                .addClass(day["holiday_ind"]? "holiday": "workday")
                .data({
                    id: day["id"], 
                    name: day["name"],
                    description: day["description"], 
                    holiday_ind: day["holiday_ind"]
                });
            });           
        }
 
        function buildUpdDays(obj) 
        {
            obj.data("holiday_ind", !obj.data("holiday_ind"));
            
            var day = {
                id: obj.data("id"),
                name: obj.data("name"),
                holiday_ind: obj.data("holiday_ind")
            }
                        
            // сравниваю объекты, т.к. inArray не работает с объектами
            var day_in_upd_days = false; 
            for (var i=0; i<upd_days.length; i++) 
            {   
                // !day.holiday_ind - старое состояние
                // конвертирую в JSON чтобы быстро сравнить объекты
                if (JSON.stringify(upd_days[i]) === JSON.stringify({
                    id: day.id, 
                    name: day.name, 
                    holiday_ind: !day.holiday_ind
                    })) {                       
                        upd_days.splice(i, 1);
                        day_in_upd_days = true;
                        break;
                }   
            }
            
            if (!day_in_upd_days) upd_days.push({
                id: day.id, 
                name: day.name, 
                holiday_ind: day.holiday_ind
            });
                        
        };
        
        function hideCalendarEdgeSwitchers()
        {
            //скрываю (сливается с фоном) переключатель для крайних значений месяца и года
            (month["prev_id"])? $("#calendar #previous_month").css("color", "white") 
                :$("#calendar #previous_month").css("color", "#0964bc");
            (month["next_id"])? $("#calendar #next_month").css("color", "white") 
                :$("#calendar #next_month").css("color", "#0964bc");
            (year["prev_id"])? $("#calendar #previous_year").css("color", "white") 
                :$("#calendar #previous_year").css("color", "#0964bc");
            (year["next_id"])? $("#calendar #next_year").css("color", "white") 
                :$("#calendar #next_year").css("color", "#0964bc");
        }

        // cобытия
        function confirmEvents() 
        {
            $("#calendar-save").on("click", function ()
            {
                $("#dialog-confirm").dialog(
                {
                    resizable: false,
                    height:180,
                    modal: true,
                    buttons: 
                    {
                        "Сохранить": function() 
                        {
                            self.act("update_days");
                            upd_days = [];
                            $(this).dialog("close");
                        },
                        "Отмена": function() 
                        {
                            $(this).dialog("close");
                        }
                    }
                });
                    
            });
        }
        
        //события для статических элементов
        function staticEvents()
        {
            // подтверждение
            confirmEvents();
            // переключатели
            $("#calendar #previous_month").on("click", function (){
                self.act("prev_month");
                hideCalendarEdgeSwitchers();
            });
            $("#calendar #next_month").on("click", function (){
                self.act("next_month");
                hideCalendarEdgeSwitchers();
            });
            $("#calendar #previous_year").on("click", function (){
                self.act("prev_year");
                hideCalendarEdgeSwitchers();
            });
            $("#calendar #next_year").on("click", function (){
                self.act("next_year");
                hideCalendarEdgeSwitchers();
            });
        }
        
        // события для динамических элементов
        function dynamicEvents() {
            // события для дней	
            $("#calendar tr.week td img").on("click", function (){
                $(this).closest("td").triggerClass("workday", "holiday", buildUpdDays($(this)));
            }); 
        }       
        //
        //
        
        //public 
        this.act = function (act_sent) 
        {               
            switch (act_sent)
            {
                case "new":
                    var today = new Date();
                    ajax({ 
                        act: act_sent,
                        month: today.getMonth() + 1,
                        year: today.getFullYear()
                    });
                    break;
                            
                case "prev_month":
                    if (month["prev_id"])
                    {
                        //январь
                        if (month["num"] == 1)
                        {       
                            if (year["prev_id"])
                                ajax({ 
                                    act: act_sent,
                                    month: month["prev_id"],
                                    year: year["prev_id"]
                                });
                        } else {
                            ajax({ 
                                act: act_sent,
                                month: month["prev_id"],
                                year: year["id"]
                            });
                        }
                    }
                    else return;
                    break;
                            
                case "next_month":
                    if (month["next_id"])
                    {
                        //декабрь
                        if (month["num"] == 12)
                        {
                            if (year["next_id"])
                                ajax({ 
                                    act: act_sent,
                                    month: month["next_id"],
                                    year: year["next_id"]
                                });
                        } else {
                            ajax({ 
                                act: act_sent,
                                month: month["next_id"],
                                year: year["id"]
                            });
                        }
                    }
                    else return;
                    break;
                            
                case "prev_year":
                    if (year["prev_id"])
                    {       
                        ajax({ 
                            act: act_sent,
                            month: month["num"],
                            year: year["prev_id"]
                        });
                    }
                    else return;
                    break;
                                    
                case "next_year":
                    if (year["next_id"])
                    {
                        ajax({ 
                            act: act_sent,
                            month: month["num"],
                            year: year["next_id"]
                        });
                    }
                    else return;
                    break;
                    
                case "update_days":
                    if (upd_days.length)
                    {
                        ajax({ 
                            act: act_sent,
                            month: month,
                            year: year,
                            days: upd_days
                        });
                    }
                    else return;
                    break;                                    
            }
            fillCalendarTable();
            // события для динамических элементов подгружаются каждый раз при обновлении данных
            dynamicEvents();
        };
        
        //public 
        this.init = function (act_sent) 
        {
            this.act(act_sent);
            // события для статических элементов подгружаются только при обновлении страницы
            staticEvents()
        } 
    }
    
    var filler = new Filler();  
    filler.init("new");    
 
});
