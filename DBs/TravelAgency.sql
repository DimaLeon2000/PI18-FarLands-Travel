SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `travel` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `travel`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `DateConvMS_MariaDB` (`dt_orig` BINARY(4)) RETURNS DATE RETURN ('0001-01-01' + INTERVAL CONV(HEX(REVERSE(dt_orig)),16,10) DAY)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `InlineMax` (`p_val1` INT, `p_val2` INT) RETURNS INT(11) BEGIN
	IF p_val1 > p_val2 THEN RETURN p_val1;
	END IF;
	RETURN IFNULL(p_val2,p_val1);
END$$

DELIMITER ;

CREATE TABLE `boardbasis` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `abbreviation` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `boardbasis` (`id`, `name`, `abbreviation`) VALUES(1, 'Без питания', 'RO');
INSERT INTO `boardbasis` (`id`, `name`, `abbreviation`) VALUES(2, 'Только завтраки', 'BB');
INSERT INTO `boardbasis` (`id`, `name`, `abbreviation`) VALUES(3, 'Полупансион', 'HB');
INSERT INTO `boardbasis` (`id`, `name`, `abbreviation`) VALUES(4, 'Расш. полупансион', 'HB+');
INSERT INTO `boardbasis` (`id`, `name`, `abbreviation`) VALUES(5, 'Пансион', 'FB');
INSERT INTO `boardbasis` (`id`, `name`, `abbreviation`) VALUES(6, 'Пансион+', 'FB+');
INSERT INTO `boardbasis` (`id`, `name`, `abbreviation`) VALUES(7, 'Всё включено', 'AI');
INSERT INTO `boardbasis` (`id`, `name`, `abbreviation`) VALUES(8, 'Ультра-всё включено', 'UAI');

CREATE TABLE `countries` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `countries` (`id`, `name`) VALUES(1, 'Бразилия');
INSERT INTO `countries` (`id`, `name`) VALUES(2, 'Португалия');
INSERT INTO `countries` (`id`, `name`) VALUES(3, 'Шри-Ланка');
INSERT INTO `countries` (`id`, `name`) VALUES(4, 'Индонезия');
INSERT INTO `countries` (`id`, `name`) VALUES(5, 'Иордания');
INSERT INTO `countries` (`id`, `name`) VALUES(6, 'Лебанон');
INSERT INTO `countries` (`id`, `name`) VALUES(7, 'Северная Ирландия');
INSERT INTO `countries` (`id`, `name`) VALUES(8, 'Турция');
INSERT INTO `countries` (`id`, `name`) VALUES(9, 'Испания');
INSERT INTO `countries` (`id`, `name`) VALUES(10, 'Тайланд');
INSERT INTO `countries` (`id`, `name`) VALUES(11, 'Вьетнам');

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `surname` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL,
  `patronymic` varchar(50) DEFAULT NULL,
  `phone` char(18) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(1, 'Ягодич', 'Карп', 'Владимирович', '8(302)988-9826');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(2, 'Мандрыка', 'Остап', 'Владиславович', '8(395)878-6637');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(3, 'Сигов', 'Богдан', 'Святославович', '8(426)478-1610');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(4, 'Эсце', 'Ксения', 'Артемовна', '8(351)481-6523');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(5, 'Чеботова', 'Елена', 'Эммануиловна', '8(842)309-0028');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(6, 'Анреп', 'Ян', 'Наумович', '8(871)349-7527');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(7, 'Покалюка', 'Антонина', 'Радиславовна', '8(862)185-0811');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(8, 'Борцова', 'Зинаида', 'Павловна', '8(812)932-7587');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(9, 'Мохов', 'Борис', 'Кондратович', '8(369)419-1024');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(10, 'Кружкова', 'Ирина', 'Марковна', '8(471)179-8433');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(11, 'Фарышева', 'Каролина', 'Казимировна', '8(474)854-4059');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(12, 'Сиянков', 'Иосиф', 'Остапович', '8(855)158-6539');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(13, 'Меншикова', 'Лариса', 'Игоревна', '8(388)190-0480');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(14, 'Марьин', 'Харитон', 'Ильевич', '8(349)214-1541');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(15, 'Ахременко', 'Артемий', 'Иосифович', '8(387)120-8618');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(16, 'Устюжанина', 'Инесса', 'Клавдиевна', '8(848)762-6694');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(17, 'Шумов', 'Рубен', 'Ермолаевич', '8(815)100-0279');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(18, 'Шапиро', 'Майя', 'Ефимовна', '8(347)448-7380');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(19, 'Малкина', 'Клара', 'Владиленовна', '8(851)747-7676');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(20, 'Афанасьев', 'Ираклий', 'Трофимович', '8(847)740-8810');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(21, 'Сязи', 'Кондрат', 'Георгиевич', '8(495)485-5190');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(22, 'Просвирякова', 'Софья', 'Капитоновна', '8(494)616-8104');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(23, 'Муравьева', 'Яна', 'Филипповна', '8(879)776-6659');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(24, 'Косяк', 'Виктория', 'Феликсовна', '8(341)703-0232');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(25, 'Логинова', 'Алла', 'Юрьевна', '8(867)608-6897');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(26, 'Колобков', 'Иван', 'Петрович', '8(848)692-2131');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(27, 'Разумова', 'Ирина', 'Александровна', '8(815)659-0471');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(28, 'Терехова', 'Ольга', 'Николаевна', '8(843)719-3113');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(29, 'Наумова', 'Татьяна', 'Петровна', '8(836)617-5139');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(30, 'Павлов', 'Олег', 'Андреевич', '8(427)619-5019');
INSERT INTO `customers` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(31, 'Леонтьева', 'Эра', 'Алексеевна', '8(924)375-4535');

CREATE TABLE `departurecities` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `departurecities` (`id`, `name`) VALUES(1, 'Москва');
INSERT INTO `departurecities` (`id`, `name`) VALUES(2, 'Санкт-Петербург');
INSERT INTO `departurecities` (`id`, `name`) VALUES(3, 'Абакан');
INSERT INTO `departurecities` (`id`, `name`) VALUES(4, 'Архангельск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(5, 'Астрахань');
INSERT INTO `departurecities` (`id`, `name`) VALUES(6, 'Барнаул');
INSERT INTO `departurecities` (`id`, `name`) VALUES(7, 'Белгород');
INSERT INTO `departurecities` (`id`, `name`) VALUES(8, 'Благовещенск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(9, 'Владивосток');
INSERT INTO `departurecities` (`id`, `name`) VALUES(10, 'Волгоград');
INSERT INTO `departurecities` (`id`, `name`) VALUES(11, 'Воронеж');
INSERT INTO `departurecities` (`id`, `name`) VALUES(12, 'Екатеринбург');
INSERT INTO `departurecities` (`id`, `name`) VALUES(13, 'Иркутск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(14, 'Казань');
INSERT INTO `departurecities` (`id`, `name`) VALUES(15, 'Калининград');
INSERT INTO `departurecities` (`id`, `name`) VALUES(16, 'Калуга');
INSERT INTO `departurecities` (`id`, `name`) VALUES(17, 'Кемерово');
INSERT INTO `departurecities` (`id`, `name`) VALUES(18, 'Кировск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(19, 'Краснодар');
INSERT INTO `departurecities` (`id`, `name`) VALUES(20, 'Красноярск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(21, 'Липецк');
INSERT INTO `departurecities` (`id`, `name`) VALUES(22, 'Магнитогорск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(23, 'Махачкала');
INSERT INTO `departurecities` (`id`, `name`) VALUES(24, 'Минеральные Воды');
INSERT INTO `departurecities` (`id`, `name`) VALUES(25, 'Мурманск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(26, 'Нижневартовск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(27, 'Нижнекамск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(28, 'Нижний Новгород');
INSERT INTO `departurecities` (`id`, `name`) VALUES(29, 'Новокузнецк');
INSERT INTO `departurecities` (`id`, `name`) VALUES(30, 'Новосибирск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(31, 'Омск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(32, 'Оренбург');
INSERT INTO `departurecities` (`id`, `name`) VALUES(33, 'Пермь');
INSERT INTO `departurecities` (`id`, `name`) VALUES(34, 'Петропавловск-Камчатский');
INSERT INTO `departurecities` (`id`, `name`) VALUES(35, 'Ростов-на-Дону');
INSERT INTO `departurecities` (`id`, `name`) VALUES(36, 'Самара');
INSERT INTO `departurecities` (`id`, `name`) VALUES(37, 'Саратов');
INSERT INTO `departurecities` (`id`, `name`) VALUES(38, 'Сочи');
INSERT INTO `departurecities` (`id`, `name`) VALUES(39, 'Ставрополь');
INSERT INTO `departurecities` (`id`, `name`) VALUES(40, 'Сургут');
INSERT INTO `departurecities` (`id`, `name`) VALUES(41, 'Сыктывкар');
INSERT INTO `departurecities` (`id`, `name`) VALUES(42, 'Томск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(43, 'Тюмень');
INSERT INTO `departurecities` (`id`, `name`) VALUES(44, 'Улан-Удэ');
INSERT INTO `departurecities` (`id`, `name`) VALUES(45, 'Ульяновск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(46, 'Уфа');
INSERT INTO `departurecities` (`id`, `name`) VALUES(47, 'Ухта');
INSERT INTO `departurecities` (`id`, `name`) VALUES(48, 'Хабаровск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(49, 'Ханты-Мансийск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(50, 'Чебоксары');
INSERT INTO `departurecities` (`id`, `name`) VALUES(51, 'Челябинск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(52, 'Чита');
INSERT INTO `departurecities` (`id`, `name`) VALUES(53, 'Южно-Сахалинск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(54, 'Якутск');
INSERT INTO `departurecities` (`id`, `name`) VALUES(55, 'Ярославль');

CREATE TABLE `employees` (
  `id` smallint(6) NOT NULL,
  `surname` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL,
  `patronymic` varchar(50) DEFAULT NULL,
  `phone` char(18) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(1, 'Булгаков', 'Кузьма', 'Ермолаевич', '8(384)379-2655');
INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(2, 'Галиаскаров', 'Виссарион', 'Эдуардович', '8(457)449-0861');
INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(3, 'Шишмарёв', 'Порфирий', 'Михаилович', '8(988)222-2780');
INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(4, 'Горчакова', 'Марианна', 'Евремовна', '8(139)311-4585');
INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(5, 'Посохов', 'Никон', 'Егорович', '8(244)637-3521');
INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(6, 'Яндарбиев', 'Валентин', 'Еремеевич', '8(058)382-1241');
INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(7, 'Феднов', 'Ростислав', 'Олегович', '8(401)729-3008');
INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(8, 'Кярбера', 'Милена', 'Елизаровна', '8(181)233-1452');
INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(9, 'Гольдина', 'Альбина', 'Капитоновна', '8(439)379-1278');
INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `phone`) VALUES(10, 'Бочкарёв', 'Даниил', 'Иннокентиевич', '8(405)080-0219');

CREATE TABLE `hotels` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `class` varchar(5) NOT NULL,
  `boardBasisID` tinyint(3) UNSIGNED NOT NULL,
  `countryID` tinyint(3) UNSIGNED DEFAULT NULL,
  `imgLink` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(1, 'Continental Inn Hotel', '4*', 3, 1, 'brazil-continental-inn.jpg');
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(2, 'Eco Paradise Hotel', '3*', 5, 1, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(3, 'Conrad Algarve', '5*', 7, 2, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(4, 'Barberyn Beach Ayurveda Resort', '4*', 7, 3, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(5, 'Cocco Resort Hotel', '3*', 2, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(6, 'Korient Mira Hotel', '3*', 7, 8, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(7, 'Ares Blue Hotel', '4*', 7, 8, '4262326.jpg');
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(8, 'Serin Hotel', '3*', 7, 8, 'serin-hotel.jpg');
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(9, 'Club Dorado', '3*', 7, 8, 'club-dorado.jpg');
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(10, 'Chang Residence Patong', '3*', 5, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(11, 'Rigel Hotel', '4*', 5, 11, '2733498_17090817240056166778.jpg');
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(12, 'Golden Lotus Hotel', '2*', 1, 11, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(13, 'Zen Hotel', '2*', 1, 11, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(14, 'Hanka Star Hotel', '2*', 2, 11, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(15, 'Azure Phuket Hotel', '3*', 5, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(16, 'Dai Duong Hotel', '2*', 1, 11, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(17, 'Ocean Bay Hotel', '2*', 2, 11, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(18, 'Long Beach Hotel', '2*', 1, 11, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(19, 'Hanatel Hotel', '2*', 1, 11, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(20, 'Jiraporn Hill Resort Patong', '3*', 1, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(21, 'Azure Hotel Bangla', '3*', 5, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(22, 'Tuana Patong Holiday', '3*', 5, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(23, 'Triple Three Hotel Patong', '3*', 2, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(24, 'Karon Village', '3*', 2, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(25, 'Chang Club Hotel', '3*', 5, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(26, 'Tiger Inn', '3*', 5, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(27, 'Tiger Complex Patong', '3*', 5, 10, 'tiger-hotel.jpg');
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(28, 'The Frutta Boutique Hotel', '3*', 2, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(29, 'Royal Crown Hotel & Palm Spa Resort', '3*', 2, 10, NULL);
INSERT INTO `hotels` (`id`, `name`, `class`, `boardBasisID`, `countryID`, `imgLink`) VALUES(30, 'Hemingways\'s Hotel', '3*', 2, 10, NULL);

CREATE TABLE `msgs` (
  `id` int(11) UNSIGNED NOT NULL,
  `subject` varchar(80) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `title` varchar(80) NOT NULL DEFAULT '[title missing]',
  `datetime` timestamp NOT NULL DEFAULT current_timestamp(),
  `author` varchar(30) NOT NULL DEFAULT 'Аноним',
  `body` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `news` (`id`, `title`, `datetime`, `author`, `body`) VALUES(1, 'ПРОВЕРКА', '2021-06-07 15:56:31', 'Леонтьев Д.В.', 'Держись ... очень крепко ...');
INSERT INTO `news` (`id`, `title`, `datetime`, `author`, `body`) VALUES(2, 'День завершения', '2021-06-07 15:56:15', 'Леонтьев Д.В.', 'После трудных времен программирования сайт наконец-то был запущен.');

CREATE TABLE `orderdetails` (
  `id` int(11) NOT NULL,
  `hotelID` int(11) NOT NULL,
  `departCityID` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(1, 7, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(2, 7, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(3, 8, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(4, 9, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(5, 6, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(6, 5, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(7, 10, 1);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(8, 11, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(9, 7, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(10, 9, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(11, 8, 1);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(12, 7, 1);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(13, 11, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(14, 6, 2);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(15, 8, 2);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(16, 7, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(17, 9, 2);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(18, 6, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(19, 9, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(20, 8, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(21, 7, 2);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(22, 26, 52);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(23, 10, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(24, 7, 1);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(25, 8, 2);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(29, 27, 2);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(27, 7, 13);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(28, 9, 2);
INSERT INTO `orderdetails` (`id`, `hotelID`, `departCityID`) VALUES(30, 7, 52);

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `employeeID` smallint(6) DEFAULT NULL,
  `customerID` int(11) DEFAULT NULL,
  `discountPercentage` tinyint(3) UNSIGNED NOT NULL,
  `price` decimal(15,4) NOT NULL,
  `requestDate` date NOT NULL,
  `departDate` date DEFAULT NULL,
  `qtyAdults` tinyint(3) UNSIGNED NOT NULL,
  `qtyChildren` tinyint(3) UNSIGNED NOT NULL,
  `days` int(11) NOT NULL,
  `nights` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(1, 1, 1, 1, '159984.0000', '2020-03-01', '2020-03-05', 2, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(2, 1, 2, 10, '159984.0000', '2020-03-02', '2020-03-05', 2, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(3, 1, 3, 1, '119988.0000', '2020-03-03', '2020-03-08', 2, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(4, 2, 4, 5, '179982.0000', '2020-03-04', '2020-03-08', 3, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(5, 2, 5, 3, '164983.5000', '2020-03-06', '2020-03-09', 2, 1, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(6, 2, 1, 5, '239976.0000', '2020-03-08', '2020-03-12', 1, 0, 8, 7);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(7, 3, 2, 10, '209979.0000', '2020-03-10', '2020-03-13', 2, 2, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(8, 3, 3, 5, '239976.0000', '2020-03-11', '2020-03-16', 3, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(9, 3, 4, 2, '159984.0000', '2020-03-13', '2020-03-17', 2, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(10, 4, 5, 3, '59994.0000', '2020-03-16', '2020-03-21', 1, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(11, 4, 1, 0, '787421.2500', '2020-03-20', '2020-03-25', 3, 1, 6, 7);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(12, 4, 2, 10, '329967.0000', '2020-03-22', '2020-03-25', 2, 1, 3, 3);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(13, 5, 3, 2, '239976.0000', '2020-03-25', '2020-03-30', 3, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(14, 5, 4, 5, '374962.5000', '2020-03-28', '2020-04-01', 1, 2, 5, 4);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(15, 5, 5, 3, '404959.5000', '2020-03-30', '2020-04-02', 3, 2, 3, 3);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(16, 6, 1, 2, '239976.0000', '2020-04-04', '2020-04-07', 2, 0, 3, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(17, 6, 2, 8, '209979.0000', '2020-04-08', '2020-04-12', 2, 2, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(18, 6, 3, 1, '89991.0000', '2020-04-10', '2020-04-14', 1, 0, 3, 3);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(19, 7, 4, 6, '224977.5000', '2020-04-12', '2020-04-16', 3, 1, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(20, 7, 5, 3, '404959.5000', '2020-04-14', '2020-04-19', 3, 2, 2, 3);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(21, 7, 1, 2, '239976.0000', '2020-04-17', '2020-04-21', 2, 0, 3, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(22, 8, 3, 2, '239976.0000', '2020-04-22', '2020-04-27', 2, 0, 3, 4);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(23, 8, 4, 5, '179982.0000', '2020-04-25', '2020-04-30', 3, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(24, 9, 5, 3, '159984.0000', '2020-04-29', '2020-05-02', 2, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(25, 9, 2, 9, '59994.0000', '2020-05-07', '2020-05-12', 1, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(26, 10, 3, 1, '119988.0000', '2020-05-11', '2020-05-15', 2, 0, 2, 2);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(27, 10, 4, 5, '239976.0000', '2020-05-16', '2020-05-19', 2, 0, 3, 3);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(28, 10, 5, 5, '157484.2500', '2020-05-20', '2020-05-24', 1, 1, 3, 3);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(29, 4, 6, 10, '119988.0000', '2020-09-01', '2020-09-03', 1, 0, 4, 4);
INSERT INTO `orders` (`id`, `employeeID`, `customerID`, `discountPercentage`, `price`, `requestDate`, `departDate`, `qtyAdults`, `qtyChildren`, `days`, `nights`) VALUES(30, 4, 31, 5, '139986.0000', '2020-09-10', '2020-09-30', 1, 1, 2, 2);
DELIMITER $$
CREATE TRIGGER `trg_priceDelete` AFTER DELETE ON `orders` FOR EACH ROW UPDATE orders,orderDetails,hotels SET orders.price = (orders.qtyAdults + orders.qtyChildren * 0.75) * InlineMax(orders.days, orders.nights) * CAST(SUBSTRING(hotels.class,1,1) as UNSIGNED INT) * 9999 WHERE (orders.ID = orderDetails.ID) AND (orderDetails.HotelID = hotels.ID) AND (hotels.Class IS NOT NULL)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_priceInsert` AFTER INSERT ON `orders` FOR EACH ROW UPDATE orders,orderDetails,hotels SET orders.price = (orders.qtyAdults + orders.qtyChildren * 0.75) * InlineMax(orders.days, orders.nights) * CAST(SUBSTRING(hotels.class,1,1) as UNSIGNED INT) * 9999 WHERE (orders.ID = orderDetails.ID) AND (orderDetails.HotelID = hotels.ID) AND (hotels.Class IS NOT NULL)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_priceUpdate` AFTER UPDATE ON `orders` FOR EACH ROW UPDATE orders,orderDetails,hotels SET orders.price = (orders.qtyAdults + orders.qtyChildren * 0.75) * InlineMax(orders.days, orders.nights) * CAST(SUBSTRING(hotels.class,1,1) as UNSIGNED INT) * 9999 WHERE (orders.ID = orderDetails.ID) AND (orderDetails.HotelID = hotels.ID) AND (hotels.Class IS NOT NULL)
$$
DELIMITER ;
CREATE TABLE `vue_countfinal` (
`ФИО служащего` varchar(35)
,`Сумма всех заказов` decimal(37,4)
,`Кол-во всех выполненных заказов` bigint(21)
);
CREATE TABLE `vue_customerpricesum` (
`Имя клиента` varchar(30)
,`Номер телефона` char(18)
,`Сумма всех заказов` decimal(37,4)
);
CREATE TABLE `vue_employeemax` (
`ФИО Служащего` varchar(35)
,`Стоимость заказа` decimal(15,4)
);
CREATE TABLE `vue_hotelnamefirstletter` (
`Наименование отелей` varchar(50)
);
DROP TABLE IF EXISTS `vue_countfinal`;

CREATE VIEW `vue_countfinal`  AS SELECT concat(`employees`.`surname`,' ',left(`employees`.`name`,1),'.',left(`employees`.`patronymic`,1),'.') AS `ФИО служащего`, sum(`orders`.`price`) AS `Сумма всех заказов`, count(`orders`.`id`) AS `Кол-во всех выполненных заказов` FROM (`orders` join `employees`) WHERE `orders`.`employeeID` = `employees`.`id` AND `orders`.`departDate` < cast(current_timestamp(3) as date) GROUP BY concat(`employees`.`surname`,' ',left(`employees`.`name`,1),'.',left(`employees`.`patronymic`,1),'.') HAVING count(`orders`.`id`) > 1 ;
DROP TABLE IF EXISTS `vue_customerpricesum`;

CREATE VIEW `vue_customerpricesum`  AS SELECT `customers`.`name` AS `Имя клиента`, `customers`.`phone` AS `Номер телефона`, sum(`orders`.`price`) AS `Сумма всех заказов` FROM (`customers` join `orders`) WHERE `customers`.`id` = `orders`.`customerID` GROUP BY `customers`.`name`, `customers`.`phone` HAVING sum(`orders`.`price`) > 1360000 ;
DROP TABLE IF EXISTS `vue_employeemax`;

CREATE VIEW `vue_employeemax`  AS SELECT concat(`employees`.`surname`,' ',left(`employees`.`name`,1),'.',left(`employees`.`patronymic`,1),'.') AS `ФИО Служащего`, max(`orders`.`price`) AS `Стоимость заказа` FROM (`orders` join `employees`) WHERE `orders`.`employeeID` = `employees`.`id` AND `orders`.`price` = (select max(`orders`.`price`) from `orders`) GROUP BY concat(`employees`.`surname`,' ',left(`employees`.`name`,1),'.',left(`employees`.`patronymic`,1),'.') ;
DROP TABLE IF EXISTS `vue_hotelnamefirstletter`;

CREATE VIEW `vue_hotelnamefirstletter`  AS SELECT `hotels`.`name` AS `Наименование отелей` FROM `hotels` WHERE left(`hotels`.`name`,1) = 'C' ;


ALTER TABLE `boardbasis`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ind_customers` (`id`,`surname`,`name`,`patronymic`,`phone`);

ALTER TABLE `departurecities`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ind_employees` (`id`,`surname`,`name`,`patronymic`,`phone`);

ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_hotels_countries` (`countryID`),
  ADD KEY `fk_hotels_boardBasis` (`boardBasisID`);

ALTER TABLE `msgs`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `orderdetails`
  ADD KEY `FK_orderDetails_departureCities` (`departCityID`),
  ADD KEY `FK_orderDetails_hotels` (`hotelID`),
  ADD KEY `FK_orderDetails_orders` (`id`);

ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_orders_customers` (`customerID`),
  ADD KEY `FK_orders_employees` (`employeeID`);


ALTER TABLE `boardbasis`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `countries`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `departurecities`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `employees`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `hotels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `msgs`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;


ALTER TABLE `hotels`
  ADD CONSTRAINT `FK_hotels_boardBasis` FOREIGN KEY (`boardBasisID`) REFERENCES `boardbasis` (`id`),
  ADD CONSTRAINT `FK_hotels_countries` FOREIGN KEY (`countryID`) REFERENCES `countries` (`id`) ON DELETE SET NULL;

ALTER TABLE `orderdetails`
  ADD CONSTRAINT `FK_orderDetails_departureCities` FOREIGN KEY (`departCityID`) REFERENCES `departurecities` (`id`),
  ADD CONSTRAINT `FK_orderDetails_hotels` FOREIGN KEY (`hotelID`) REFERENCES `hotels` (`id`),
  ADD CONSTRAINT `FK_orderDetails_orders` FOREIGN KEY (`id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `orders`
  ADD CONSTRAINT `FK_orders_customers` FOREIGN KEY (`customerID`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `FK_orders_employees` FOREIGN KEY (`employeeID`) REFERENCES `employees` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
