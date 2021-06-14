<?php
	setlocale(LC_ALL, "russian.utf8");
	date_default_timezone_set ('Asia/Chita');
	$headerMenu = [
		['link'=>'🏠 Домой', 'href'=>'/'],
		['link'=>'📰 Новости', 'href'=>'/?id=news'],
		['link'=>'ℹ О нас', 'href'=>'/?id=about'],
		['link'=>'📫 Путёвки', 'href'=>'/?id=orders'],
		['link'=>'🚩 Наши туры', 'href'=>'/?id=tours'],
		['link'=>'👥 Контакты', 'href'=>'/?id=contact']
		];
	$day = strftime('%d');
	$mon = strftime('%B');
	$year = strftime('%Y');
	$hour = (int)strftime('%H');
	define('COPYRIGHT', 'Леонтьев Д.В.');
?>