<?php
	function test_input($data) {
		$data = trim($data);
		$data = stripslashes($data);
		$data = htmlspecialchars($data);
		return $data;
	}
	include 'dbConfig.php';
	if($_SERVER['REQUEST_METHOD']=='POST'){
		$email = test_input($_POST["email"]);
		if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
			$emailErr = "Invalid email format";
			exit;
		}
		$subject = clearStr($_POST['subject']);
		$msg = clearStr($_POST['body']);
		$sql = "INSERT INTO msgs(email, subject, body) VALUES('$email','$subject','$msg')";
		mysqli_query($link,$sql) or die(mysqli_error($link));
		$uri = $_SERVER['REQUEST_URI'];
		header('Location:'.$uri);
		exit;
	}
	if(isset($_GET['del'])){
		$del=abs((int)$_GET['del']);
		if($del){
			$sql="DELETE FROM msgs WHERE id=$del";
			mysqli_query($link,$sql) or die(mysqli_error($link));
			header('Location:'.$_SERVER['PHP_SELF']);
			exit;
		}
	}
	mysqli_close($link);
?>
<h3>Адрес</h3>
<p>г. Чита, ул. Балябина, 37</p>
<h3>Телефон</h3>
<p>+7(3022)19-53-00</p>
<h3>Задайте вопрос</h3>
<form action='<?= $_SERVER['REQUEST_URI'];?>' method='post'>
	<label class="required">Ваш E-mail: </label><br />
	<input name='email' type='text' size='30' maxlength='50'/><br />
	<label class="required">Тема письма: </label><br />
	<input name='subject' type='text' size='50' maxlength='50'/><br />
	<label class="required">Содержание: </label><br />
	<textarea name='body' cols="50" rows="10"></textarea><br /><br />
	<input type='submit' value='Отправить' />
</form>