<?php
session_start();
$contents=file_get_contents("user.txt");
$lines=explode("/",$contents);
while (list($pos,$line)=each($lines)){
	$data=explode(":",$line);
	if ($data[0]==$_POST['user'])
		if (md5($_POST['pass'])==$data[1]){
			echo "login OK<br>";
			$_SESSION["logged"]=1;
		}
		else{
			echo "login failed<br>";
			$_SESSION["logged"]=0;
		}
}
if ($_SESSION["logged"]==1)
	echo "<a href=session.php>Get busy</a>";
else{
	session_unset();
	session_destroy();
}
?>
