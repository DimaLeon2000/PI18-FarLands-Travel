<?php
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
	include 'data.inc.php';
	include 'lib.inc.php';
	//Не забудь ставить output_buffering в php.ini на "4096", иначе заголовки HTTP не будет модифицированы
	$title = '';
	$header = "Главная страница";
	$id = isset($_GET['id']) ? strtolower(strip_tags(trim($_GET['id']))) : '';
	switch ($id) {
		case 'about':
			$title = 'О FarLands - ';
			$header = 'ℹ О нас';
			break;
		case 'orders':
			$title = 'Путёвки - ';
			$header = '📫 Путёвки';
			break;
		case 'tours':
			$title = 'Наши туры - ';
			$header = '🚩 Наши туры';
			break;
		case 'contact':
			$title = 'Контакты - ';
			$header = '👥 Обратная связь';
			break;
		case 'news':
			$title = 'Новости - ';
			$header = '📰 Новости';
			break;
		case 'admin':
			$title = 'Администрирование - ';
			$header = '🛠 Панель администратора';
			break;
		default:
			break;
	}
	switch (http_response_code()) {
		case 401:
			$header = 'Требуется авторизация! ('.http_response_code().')';
			break;
		case 403:
			$header = 'Доступ отказан! ('.http_response_code().')';
			break;
		case 404:
			$header = 'Мы не туда пошли! ('.http_response_code().')';
			break;
		default:
			break;
	}
	$realm = 'Access to the Control Panel';
	$users = array('admin' => '4u514nd3r');
	
	if ($id == 'admin') {
		if (isset($_GET['action']) && ($_GET['action'] == 'logout')) {
			header('HTTP/1.0 401 Unauthorized');
		}
		if (empty($_SERVER['PHP_AUTH_DIGEST'])) {
			header('HTTP/1.0 401 Unauthorized');
			header('WWW-Authenticate: Digest realm="'.$realm.'",qop="auth",nonce="'.uniqid().'",opaque="'.md5($realm).'"');
			die(include '401.html');
		}
	}
	if (isset($_SERVER['PHP_AUTH_DIGEST'])) {
		if (!($data = http_digest_parse($_SERVER['PHP_AUTH_DIGEST'])) ||
			!isset($users[$data['username']]))
			exit;
		$A1 = md5($data['username'] . ':' . $realm . ':' . $users[$data['username']]);
		$A2 = md5($_SERVER['REQUEST_METHOD'].':'.$data['uri']);
		$valid_response = md5($A1.':'.$data['nonce'].':'.$data['nc'].':'.$data['cnonce'].':'.$data['qop'].':'.$A2);
		if (($data['response'] == $valid_response) && !(isset($_GET['action']) && ($_GET['action'] == 'logout')))
			array_push($headerMenu,['link'=>'⛔ Администрирование', 'href'=>'/?id=admin']);
	}
?>
<!DOCTYPE html>
<html>
	<head>
		<title><?= $title?>⛰ Турагентство FarLands 🧭</title>
		<meta charset="utf-8"/>
		<link rel="stylesheet" type="text/css" href="style.css" />
		<script src="jquery-3.6.0.min.js"></script>
		<link rel="shortcut icon" type="image/svg" href="svg/logo-favicon.svg"/>
	</head>
	<body>
		<div class="header">
			<!-- Верхняя часть страницы -->
			<?php include 'top.inc.php'?>
			<!-- Верхняя часть страницы -->
		</div>
		<div class="content">
			<!-- Заголовок -->
			<h1><?= $header?></h1>
			<!-- Заголовок -->
			<!-- Область основного контента -->
			<?php switch($id){
				case 'about': include 'about.php'; break;
				case 'contact': include 'contact.php'; break;
				case 'tours': include 'tours.php'; break;
				case 'orders': include 'orders.php'; break;
				case 'news': include 'news.php'; break;
				case 'err404': include '404.html'; break;
				case 'admin': include 'admin.php'; break;
				default: include 'index.inc.php';
			}
			?>
			<!-- Область основного контента -->
			<div class="clearfix"></div>
		</div>
		<div class="footer">
			<!-- Нижняя часть страницы -->
			<?php include 'bottom.inc.php'?>
			<!-- Нижняя часть страницы -->
		</div>
		<script>
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    /* Toggle between adding and removing the "active" class,
    to highlight the button that controls the panel */
    this.classList.toggle("active");

    /* Toggle between hiding and showing the active panel */
    var panel = this.nextElementSibling;
    if (panel.style.display === "block") {
      panel.style.display = "none";
    } else {
      panel.style.display = "block";
    }
  });
}
</script>
	</body>
</html>