<?php
	$realm = 'Access to the Control Panel';
	$users = array('admin' => '4u514nd3r');

	if (empty($_SERVER['PHP_AUTH_DIGEST'])) {
		header('HTTP/1.0 401 Unauthorized');
		include '401.html';
		header('WWW-Authenticate: Digest realm="'.$realm.'",qop="auth",nonce="'.uniqid().'",opaque="'.md5($realm).'"');
	}

	if (!($data = http_digest_parse($_SERVER['PHP_AUTH_DIGEST'])) ||
		!isset($users[$data['username']]))
		die('Неправильные данные!');

	$A1 = md5($data['username'] . ':' . $realm . ':' . $users[$data['username']]);
	$A2 = md5($_SERVER['REQUEST_METHOD'].':'.$data['uri']);
	$valid_response = md5($A1.':'.$data['nonce'].':'.$data['nc'].':'.$data['cnonce'].':'.$data['qop'].':'.$A2);

	if ($data['response'] != $valid_response)
		die('Неправильные данные!');

	// функция разбора заголовка http auth
	function http_digest_parse($txt)
	{
		// защита от отсутствующих данных
		$needed_parts = array('nonce'=>1, 'nc'=>1, 'cnonce'=>1, 'qop'=>1, 'username'=>1, 'uri'=>1, 'response'=>1);
		$data = array();
		$keys = implode('|', array_keys($needed_parts));

		preg_match_all('@(' . $keys . ')=(?:([\'"])([^\2]+?)\2|([^\s,]+))@', $txt, $matches, PREG_SET_ORDER);

		foreach ($matches as $m) {
			$data[$m[1]] = $m[3] ? $m[3] : $m[4];
			unset($needed_parts[$m[1]]);
		}
		return $needed_parts ? false : $data;
	}

	include 'dbConfig.php';
	if($_SERVER['REQUEST_METHOD']=='POST'){
		$sql = '';
		switch($_POST['frmname']) {
			case 'news': {
				$title=clearStr($_POST['nTitle']);
				$author=clearStr($_POST['nAuthor']);
				$body=$_POST['nBody'];
				if (isset($_POST['nTitle']) and isset($_POST['nAuthor']) and isset($_POST['nBody']) and $_POST['action']=='Insert') {
					$sql = "INSERT INTO news(title,author,body) VALUES ('$title','$author','$body')";
				}
				if (isset($_POST['nID'])){
					$itemID = intval($_POST['nID']);
					if ($_POST['action']=='Update') {
						$sql = "UPDATE news SET title='$title', author='$author', body='$body' WHERE id=$itemID";
					}
					if ($_POST['action']=='Delete') {
						$sql = "DELETE FROM news WHERE id=$itemID";
					}
				}
				break;
			}
			case 'hotels': {
				$name=clearStr($_POST['hName']);
				$class=clearStr($_POST['hClass']);
				$boardBasis=intval($_POST['hBoardBasis']);
				$country=intval($_POST['hCountry']);
				$hImgLink=clearStr($_POST['hImgLink']);
				if ($hImgLink=='noImg' AND isset($_FILES["hImgUpload"])) {
					$hImgLink=$_FILES["hImgUpload"]["name"];
					include('upload.php');
				}
				if (isset($_POST['hName']) and isset($_POST['hClass']) and isset($_POST['hBoardBasis']) and isset($_POST['hCountry']) and $_POST['action']=='Insert') {
					$sql = "INSERT INTO hotels(name,class,boardbasisid,countryid,imgLink) VALUES ('$name','$class',$boardBasis,$country,'$hImgLink')";
				}
				if (isset($_POST['hID'])){
					$itemID = intval($_POST['hID']);
					if ($_POST['action']=='Update') {
						$sql = "UPDATE hotels SET name='$name', class='$class', boardBasisID=$boardBasis, countryID=$country, imgLink='$hImgLink' WHERE id=$itemID";
					}
					if ($_POST['action']=='Delete') {
						$sql = "DELETE FROM hotels WHERE id=$itemID";
					}
				}
				break;
			}
			case 'countries': {
				$name=clearStr($_POST['cnName']);
				if (isset($_POST['cnName']) and $_POST['action']=='Insert') {
					$sql = "INSERT INTO countries(name) VALUES ('$name')";
				}
				if (isset($_POST['cnID'])){
					$itemID = intval($_POST['cnID']);
					if ($_POST['action']=='Update') {
						$sql = "UPDATE countries SET name='$name' WHERE id=$itemID";
					}
					if ($_POST['action']=='Delete') {
						$sql = "DELETE FROM countries WHERE id=$itemID";
					}
				}
				break;
			}
			case 'msgs': {
				if ($_POST['action']=='Delete' and isset($_POST['msgID'])) {
					$itemID = intval($_POST['cnID']);
					$sql = "DELETE FROM msgs WHERE id=$itemID";
				}
				break;
			}
		}
		mysqli_query($link,$sql) or die(mysqli_error($link));
		$sql = '';
		if ($_POST['frmname']=='news') {
			$sql = "ALTER TABLE news AUTO_INCREMENT = 1";
		} elseif ($_POST['frmname']=='hotels') {
			$sql = "ALTER TABLE hotels AUTO_INCREMENT = 1";
		} elseif ($_POST['frmname']=='orders') {
			$sql = "ALTER TABLE orders AUTO_INCREMENT = 1";
		} elseif ($_POST['frmname']=='countries') {
			$sql = "ALTER TABLE countries AUTO_INCREMENT = 1";
		} elseif ($_POST['frmname']=='msgs') {
			$sql = "ALTER TABLE msgs AUTO_INCREMENT = 1";
		}
		if ($sql <> '') mysqli_query($link,$sql) or die(mysqli_error($link));
		header('Location:'.$_SERVER['PHP_SELF'].'?id=admin');
		exit;
	}
	echo "<button class='accordion'>Новости</button>";
	echo "<div class='panel'>";
	$sql= "SELECT id, title, author, body, UNIX_TIMESTAMP(datetime) as dt FROM news ORDER BY id DESC";
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	echo '<form action=\''.$_SERVER['REQUEST_URI'].'\' method=\'post\'>';
	echo '<input type="hidden" name="frmname" value="news"/>';
	while($row=mysqli_fetch_assoc($res)){
		$itemID=$row['id'];
		$nTitle=$row['title'];
		$nAuthor=$row['author'];
		$nDate=date('d-m-Y H:i:s',$row['dt']);
		$nBody=$row['body'];
		echo <<<HTML
<input type="radio" id="n$itemID" name="nID" value="$itemID">
<label for="n$itemID">$nTitle | $nAuthor | $nDate</label><br />
HTML;}
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	$rows=json_encode(mysqli_fetch_all($res,MYSQLI_ASSOC));
	echo "<label>Название статьи: </label><br /><input name='nTitle' type='text' size='30' maxlength='80'/><br />";
	echo "<label>Автор статьи: </label><br /><input name='nAuthor' type='text' size='30' maxlength='30'/><br />";
	echo "<label>Содержание: </label><br /><textarea name='nBody' cols='50' rows='10'></textarea><br /><br />";
	echo "<input type='submit' name='action' value='Insert' />";
	echo "<input type='submit' name='action' value='Update' />";
	echo "<input type='submit' name='action' value='Delete' />";
	echo <<<HTML
<script>$('input[type="radio"][name="nID"]').on('change', function(e) {
	var sel = this.value;
	var newsArt = $rows;
	document.getElementsByName('nTitle')[0].value = newsArt.find(x => x.id === String(sel)).title;
	document.getElementsByName('nAuthor')[0].value = newsArt.find(x => x.id === String(sel)).author;
	document.getElementsByName('nBody')[0].value = newsArt.find(x => x.id === String(sel)).body;
});</script>
HTML;
	echo '</form></div>';

	echo '<button class="accordion">Отели</button>';
	echo '<div class="panel">';
	$sql= "SELECT h.id, h.name, h.class, h.boardBasisID, b.abbreviation as bAbbr, h.countryID, c.name as cnName, h.imgLink FROM hotels h, boardBasis b, countries c WHERE (h.boardBasisID = b.id AND h.countryID = c.id) ORDER BY h.id DESC";
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	echo '<form action="'.$_SERVER['REQUEST_URI'].'" method="post" enctype="multipart/form-data">';
	echo '<input type="hidden" name="frmname" value="hotels"/>';
	while($row=mysqli_fetch_assoc($res)){
		$itemID=$row['id'];
		$hotelName=$row['name'];
		$class=$row['class'];
		$bAbbr=$row['bAbbr'];
		$cnName=$row['cnName'];
echo <<<HTML
<input type="radio" id="h$itemID" name="hID" value="$itemID">
<label for="h$itemID">$hotelName $class | $bAbbr | $cnName</label><br />
HTML;}
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	$rows=json_encode(mysqli_fetch_all($res,MYSQLI_ASSOC));
	echo "<label>Наименование отеля: </label><br /><input name='hName' type='text' size='30' maxlength='50'/><br />";
	echo "<label>Звёзднтость отеля: </label><br /><select name='hClass'>
		<option value='1*'>★ (Туристический)</option>
		<option value='2*'>★★ (Стандартный)</option>
		<option value='3*'>★★★ (Комфорт)</option>
		<option value='4*'>★★★★ (Первоклассный)</option>
		<option value='5*'>★★★★★ (Роскошь)</option>
	</select><br />";
	$sql="SELECT * from boardbasis";
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	echo "<label>Режим питания: </label><br /><select name='hBoardBasis'>";
	while($boardbases=mysqli_fetch_assoc($res)){
		$itemID=$boardbases['id'];
		$bName=$boardbases['name'];
		$bAbbr=$boardbases['abbreviation'];
		echo "<option value='$itemID'>$bAbbr - $bName</option>";}
	echo '</select><br />';
	$sql="SELECT * from countries";
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	echo "<label>Страна: </label><br /><select name='hCountry'>";
	while($countries=mysqli_fetch_assoc($res)){
		$itemID=$countries['id'];
		$cName=$countries['name'];
		echo "<option value='$itemID'>$cName</option>";}
	echo '</select><br />';
	echo '<label>Изображения отеля: </label><br />';
	echo '<input type="file" name="hImgUpload"><br />';
	echo "<select name='hImgLink'>";
	echo "<option value='noImg'>Без изображения/Новый файл...</option>";
	$dir = './img/uploads';
	$scanned_dir = array_diff(scandir($dir), array('..', '.'));
	foreach($scanned_dir as $filename)
		echo "<option value='$filename'>$filename</option>";
	echo '</select><br />';
	echo '<img name="hImgPreview" src="/img/noImg.png" style="max-width: 128px; max-height: 128px"><br />';
	echo "<input type='submit' name='action' value='Insert' />";
	echo "<input type='submit' name='action' value='Update' />";
	echo "<input type='submit' name='action' value='Delete' />";
	echo <<<HTML
<script>$('input[type="radio"][name="hID"]').on('change', function(e) {
	var sel = this.value;
	var hotels = $rows;
	document.getElementsByName('hName')[0].value = hotels.find(x => x.id === String(sel)).name;
	document.getElementsByName('hClass')[0].selectedIndex = parseInt(hotels.find(x => x.id === String(sel)).class.substr(0,1))-1;
	document.getElementsByName('hBoardBasis')[0].selectedIndex = parseInt(hotels.find(x => x.id === String(sel)).boardBasisID)-1;
	document.getElementsByName('hCountry')[0].selectedIndex = parseInt(hotels.find(x => x.id === String(sel)).countryID)-1;
	if (hotels.find(x => x.id === String(sel)).imgLink !== null) {
		document.getElementsByName('hImgPreview')[0].src = "./img/uploads/" + hotels.find(x => x.id === String(sel)).imgLink;
		document.getElementsByName('hImgLink')[0].value = hotels.find(x => x.id === String(sel)).imgLink;
	} else {
		document.getElementsByName('hImgPreview')[0].src = "./img/noImg.png";
		document.getElementsByName('hImgLink')[0].selectedIndex = 0;
	};
});
$('select[name="hImgLink"]').on('change', function(e) {
	document.getElementsByName('hImgPreview')[0].src = "./img/uploads/" + this.value;
	if (this.selectedIndex == 0) document.getElementsByName('hImgPreview')[0].src = "./img/noImg.png";
});</script>
HTML;
	echo "</form></div>";

	echo "<button class='accordion'>Страны</button>";
	echo "<div class='panel'>";
	$sql= "SELECT id, name FROM countries ORDER BY id DESC";
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	echo '<form action=\''.$_SERVER['REQUEST_URI'].'\' method=\'post\'>';
	echo '<input type="hidden" name="frmname" value="countries"/>';
	while($row=mysqli_fetch_assoc($res)){
		$itemID=$row['id'];
		$cnName=$row['name'];
		echo <<<HTML
<input type="radio" id="cn$itemID" name="cnID" value="$itemID">
<label for="cn$itemID">$cnName</label><br />
HTML;}
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	$rows=json_encode(mysqli_fetch_all($res,MYSQLI_ASSOC));
	echo "<label>Название стран: </label><br /><input name='cnName' type='text' size='30' maxlength='80'/><br /><br />";
	echo "<input type='submit' name='action' value='Insert' />";
	echo "<input type='submit' name='action' value='Update' />";
	echo "<input type='submit' name='action' value='Delete' />";
	echo <<<HTML
<script>$('input[type="radio"][name="cnID"]').on('change', function(e) {
	var sel = this.value;
	var newsArt = $rows;
	document.getElementsByName('cnName')[0].value = newsArt.find(x => x.id === String(sel)).name;
});</script>
HTML;
	echo "</form></div>";

	echo "<button class='accordion'>Сообщения клиентов</button>";
	echo "<div class='panel'>";
	$sql= "SELECT id, subject, email, body, UNIX_TIMESTAMP(datetime) as dt FROM msgs ORDER BY id DESC LIMIT 5";
	$res=mysqli_query($link,$sql) or die(mysqli_error($link));
	echo '<form action=\''.$_SERVER['REQUEST_URI'].'\' method=\'post\'>';
	echo '<input type="hidden" name="frmname" value="msgs"/>';
	while($row=mysqli_fetch_assoc($res)){
		$itemID=$row['id'];
		$msgSubject=$row['subject'];
		$msgUserEmail=$row['email'];
		$msgDate=date('d-m-Y H:i:s',$row['dt']);
		$msgBody=$row['body'];
		echo <<<HTML
<input type="radio" id="msg$itemID" name="msgID" value="$itemID">
<label for="msg$itemID"><h3>$msgSubject</h3> от <a href = "mailto:$msgUserEmail">$msgUserEmail</a> @ $msgDate<br />$msgBody</label><br />
HTML;}
	echo "<input type='submit' name='action' value='Delete' />";
	echo "</form></div>";
	mysqli_close($link);
?>