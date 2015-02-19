<?php
session_start();
$_SESSION['logged']=0;
?>
<html>
<title>
Guestbook administrator login
</title>
<body>
<form action=gblogin.php method=post>
Parola: <input type=password name=pass>
<input type=submit value=Login>
</form>
<?php 
if (count($_POST)!=0){
    if (md5($_POST['pass'])=="224c0fe38548a41ba15a33826db30f06"){
	$_SESSION['logged']=1;
    }
    if ($_SESSION['logged']==1){
	echo "Parola acceptata !<br>";
	header("Location: guests.php");
#	echo "<a href=guests.php>Du-te</a>";
    }
    else{
	echo "Parola gresita.<br>";
	session_unset();
	session_destroy();
    }
}
?>
</body>
</html>

