<?php
	setlocale(LC_ALL, "russian.utf8");
	date_default_timezone_set ('Asia/Chita');
	$headerMenu = [
		['link'=>'🏠 Домой', 'href'=>'/'],
		['link'=>'📰 Новости', 'href'=>'/?id=news'],
		['link'=>'ℹ О нас', 'href'=>'/?id=about'],
		['link'=>'🚩 Наши туры', 'href'=>'/?id=tours'],
		['link'=>'👥 Контакты', 'href'=>'/?id=contact'],
		['link'=>'⛔ Администрирование', 'href'=>'/?id=admin']
		];
	$day = strftime('%d');
	$mon = strftime('%B');
	$year = strftime('%Y');
	$hour = (int)strftime('%H');
	define('COPYRIGHT', 'Веб-мастер');
	if ($hour < 6) {$welcome = 'Доброй ночи';}
	elseif ($hour < 12) {$welcome = 'Доброе утро';}
	elseif ($hour < 18) {$welcome = 'Добрый день';}
	else {$welcome = 'Добрый вечер';}
?>