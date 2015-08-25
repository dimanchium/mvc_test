<?php

class Mainview extends view {
    
    private $js_scripts = Array();
    private $styles = Array();
    
    public function addJsScript ($path) {
        $this->js_scripts[] = $path;
    }
    
    public function addStyle ($path) {
        $this->styles[] = $path; 
    }
    
    public function getJsScripts() {
        $output = "";
        foreach ($this->js_scripts as $js_script)
        {
            $output .= "<script src='".$js_script."'></script>";
        }
        return $output;
    }

    public function getStyles() {
        $output = "";
        foreach ($this->styles as $style)
        {
            $output .= "<link rel='stylesheet' type='text/css' href='".$style."'>";
        }
        return $output;
    }

    //функция построения меню навигации по модулям
    //если указан action - активным становится модуль с ним, иначе - с первым (минимальным) priority
    public function navMenu($modules, $action = false) {
        $output = "";
        if ($action) {
            foreach ($modules as $key => $value) {   
                if ($value["action"] == $action)
                    $output .= "<a href= '?action=".$value["action"]
                        ."'><div id='module' class='active'>".$value["title"]."</div></a>";
                else
                    $output .= "<a href='?action=".$value["action"]
                        ."'><div id='module'>".$value["title"]."</div></a>";
            }
        } else {
            foreach ($modules as $key => $value) {   
                if ($key)
                    $output .= "<a href='?action=".$value["action"]
                        ."'><div id='module'>".$value["title"]."</div></a>";
                else
                    $output .= "<a href='?action=".$value["action"]
                        ."'><div id='module' class='active'>".$value["title"]."</div></a>";
            }
        }
        return $output;
    }

}

?>
