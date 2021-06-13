<?php
	include 'dbConfig.php';
	$sql= "SELECT o.id, CONCAT(e.surname,' ',LEFT(e.name,1),'.',LEFT(e.patronymic,1),'.') as employee,
	CONCAT(cst.surname,' ',LEFT(cst.name,1),'.',LEFT(cst.patronymic,1),'.') as customer,
	o.price, o.discountPercentage, o.requestDate, o.departDate,
	o.qtyAdults, o.qtyChildren, o.days, o.nights, od.hotelID, h.imgLink, h.name as hotelName, h.class as hotelClass, b.name as bbName, b.abbreviation as bbAbbr, cnt.name as country, dc.name as departCity
	FROM orders o, orderdetails od, employees e, customers cst, hotels h, boardbasis b, countries cnt, departurecities dc
	WHERE o.id = od.id AND o.employeeID = e.id AND o.customerID = cst.id AND od.hotelID = h.id AND b.id = h.boardBasisID AND cnt.id = h.countryID AND dc.id = od.departCityID
	ORDER BY o.id DESC LIMIT 5;";
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	mysqli_close($link);
	while($row=mysqli_fetch_assoc($res)){
		$id=$row['id'];
		$hotelID=$row['hotelID'];
		$hotelName=$row['hotelName'];
		$hotelClass=intval($row['hotelClass']);
		$bbName=$row['bbName'];
		$bbAbbr=$row['bbAbbr'];
		$country=$row['country'];
		//$employee=$row['employee'];
		//$customer=$row['customer'];
		$price=number_format($row['price'],2,',',' ');
		$discount=$row['discountPercentage'];
		$priceDiscounted=number_format($row['price']*(1-$discount/100),2,',',' ');
		$requestDate=$row['requestDate'];
		$departDate=$row['departDate'];
		$departCity=$row['departCity'];
		$adults=$row['qtyAdults'];
		$children=$row['qtyChildren'];
		$days=$row['days'];
		$nights=$row['nights'];
		$hotelImg=$row['imgLink'];
		echo "<button class='accordion'>№$id. $hotelName ";
		if ($hotelClass <> '') {
		for ($i = 1; $i <= $hotelClass; $i++) {
			echo '★';
		}
		echo ' ';
		}
		echo "- $country</button>";
		
		echo '<div class="panel">';
		if (isset($hotelImg)) echo "<img style='max-height: 192px; float: right' src='img/uploads/$hotelImg' alt>";
		else echo "<img style='max-height: 192px; float: right' src='img/noImg.png' alt>";
		echo '<ul>';
		echo "<li>📅 Дата вылета: $departDate</li>";
		echo "<li>🛫 Город вылета: $departCity</li>";
		echo "<li>👫 Кол-во взрослых: $adults</li>";
		if ($children >= 1) echo "<li>👶 Кол-во детей: $children</li>";
		echo "<li>🍴 Режим питания: $bbAbbr - $bbName</li>";
		if (intval($days%100/10) <> 1) {
		switch (true) {
			case ($days == 1): $daysword = 'день'; break;
			case in_array($days, range(2,4)): $daysword = 'дня'; break;
			default: $daysword = 'дней'; break;
		}} else $daysword = 'дней';
		if (intval($nights%100/10) <> 1) {
		switch (true) {
			case ($nights == 1): $nightsword = 'ночь'; break;
			case in_array($nights, range(2,4)): $nightsword = 'ночи'; break;
			default: $nightsword = 'ночей'; break;
		}} else $nightsword = 'ночей';
		echo "<li>🌙 Длительность: $days $daysword, $nights $nightsword</li>";
		//echo "<li>👤 Клиент: $customer</li>";
		//echo "<li>👤 Сотрудник: $employee</li>";
		echo "<li>💵 Стоимость: {$priceDiscounted} ₽";
		if ($discount > 0) 
			echo " <span class='strike-out opacity-50'>{$price} ₽</span> (Скидка: $discount%)</li>";
		else
			echo "</li>";
		echo "</ul><div class='clearfix'></div></div>";
	}
?>
