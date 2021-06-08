<?php
	define('DB_HOST','localhost');
	define('DB_LOGIN','root');
	define('DB_PASSWORD','');
	define('DB_NAME','travel');
	$link=mysqli_connect(DB_HOST,DB_LOGIN, DB_PASSWORD, DB_NAME);
	function clearStr($data){
		global $link;
		return mysqli_real_escape_string($link,trim(strip_tags($data)));
	}
?>