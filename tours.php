<?php
	include 'dbConfig.php';
	$sql= "SELECT t.id, t.countryID, t.departcityID, t.price, cn.name as cName, dc.name as dName FROM tours t, countries cn, departurecities dc
	WHERE t.countryid = cn.id AND t.departcityID = dc.id
	ORDER BY t.id DESC;";
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	mysqli_close($link);
	while($row=mysqli_fetch_assoc($res)){
		$id=$row['id'];
		$country=$row['cName'];
		$departCity=$row['dName'];
		$price=$row['price'];
		echo "<button class='accordion'>№$id. $departCity => $country</button>";		
		echo '<div class="panel">';
		echo '<ul>';
		echo "<li>🛫 Город вылета: $departCity</li>";
		echo "<li>🗺 Страна назначения: $country</li>";
		echo "<li>💵 Стоимость: $price ₽</li>";
		echo "</ul></div>";
	}
?>
