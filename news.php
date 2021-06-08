<?php
	include 'dbConfig.php';
	$sql= "SELECT id, title, author, body, UNIX_TIMESTAMP(datetime) as dt FROM news 
ORDER BY id DESC LIMIT 5";
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	mysqli_close($link);
	while($row=mysqli_fetch_assoc($res)){
		$id=$row['id'];
		$title=$row['title'];
		$author=$row['author'];
		$dt=date('d-m-Y H:i:s',$row['dt']);
		$articleBody=$row['body'];
		echo "<span class='news-article'><h2>$title</h2><h3>$author, $dt</h3><br>";
		echo "<article>$articleBody</article></span>";
	}
?>
