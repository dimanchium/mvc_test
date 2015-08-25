<?php 

	class Database 
	{

		public $isConnected;
		protected $database;

		public function __construct($dbtype = DB_TYPE, $host = DB_HOST, $dbname = DB_NAME, $username = DB_USER, $password = DB_PASS, $options=array())
		{
			$this->isConnected = true;
			try 
			{ 
                		$this->database = new PDO("{$dbtype}:host={$host};dbname={$dbname}", $username, $password, $options);
				$this->database->exec("SET NAMES UTF8"); 
				$this->database->exec("SET CLIENT_ENCODING TO UTF8"); 
                		$this->database->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
                		$this->database->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            		} catch(PDOException $e) 
			{ 
                		$this->isConnected = false;
                		throw new Exception($e->getMessage());
            		}
      		}


        	public function disconnect()
		{
        		$this->database = null;
        		$this->isConnected = false;
        	}


        	public function getRow($query, $params=array())
		{
        		try 
			{ 
                		$output = $this->database->prepare($query); 
               		 	$output->execute($params);
             		   	return $output->fetch();  
            		} catch(PDOException $e) 
			{
                		throw new Exception($e->getMessage());
            		}	
        	}


		public function getRows($query, $params=array())
		{
			try
			{ 
		        	$output = $this->database->prepare($query); 
		        	$output->execute($params);
		        	return $output->fetchAll();       
		    	} catch(PDOException $e) 
			{
		        	throw new Exception($e->getMessage());
		    	}       
		}
		
		
		public function setRows($query, $params)
		{
		    	try
			{ 
		        	$output = $this->database->prepare($query); 
		        	$output->execute($params);
		    	} catch(PDOException $e)
			{
		        	throw new Exception($e->getMessage());
		    	}           
		}
}
	
?>
    
