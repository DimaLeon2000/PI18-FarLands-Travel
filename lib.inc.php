<?php
	function drawTable($cols, $rows, $color) {
		echo "<table border='0'><br />";
			for ($row = 1; $row <= $rows; $row++) {
				echo "<tr>";
				for ($col = 1; $col <= $cols; $col++) {
					if (($col == 1) || ($row == 1)) {echo "<td style='background-color: ".$color."; font-weight: bold; text-align:center'>";}
					else {echo "<td>";}
					echo ($col * $row)."</td>";
				}
				echo "</tr>";
			}
			echo "</table>";	
	}
	function drawMenu($menu) {
		echo "<ul class=\"nav\">";
		foreach($menu as $menuItem)
		{
			echo "<li><a href=".$menuItem['href'].">".$menuItem['link']."</a></li>";
		}
		unset($menuItem);
		echo "</ul>";
	}
?>