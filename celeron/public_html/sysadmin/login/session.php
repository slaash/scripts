<?php
session_start();
if ($_SESSION["logged"]==1){
	echo "here is the secret of the universe<br>";
}
else{
	echo "access denied<br>";
}
session_unset();
session_destroy();
?>