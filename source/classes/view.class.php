<?php

	class View
	{

		private $content;

                
		public function __construct()
		{
			$this->content = "";
		}
                
		public function addContent($new) { $this->content .= $new; }
		public function displayContent() { echo $this->content; }
                public function getContent() { return $this->content; }
                public function setContent($content) { $this->content = $content; }

		public function errorMessage()
		{
			return 	'<div id="error_message">Ошибка</div>';	
		}

		public function successMessage()
		{
			return 	'<div id="success_message">Успешная операция</div>';
		}

		public function template($file, $parameters = Array())
		{
			$output = file_get_contents($file);
			foreach ($parameters as $key => $val) 
			{
				$replace = '{'.$key.'}';
				$output = str_replace($replace, $val, $output);
			}
			return $output;
		}

	}	

?>
