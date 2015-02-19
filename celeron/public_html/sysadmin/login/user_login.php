<?php
session_start();
$_SESSION["logged"]=0;
?>
<form action=user_login.php method=post>
Username:<input type=text name=user><br>
Password:<input type=password name=pass><br>
<input type=submit value=Login>
</form>
<?php
$user=$_POST['user'];
$pass=$_POST['pass'];
if (strlen($user)!=0 and strlen($pass)!=0){
$contents=file_get_contents("user.txt");
$lines=explode("/",$contents);
while (list($pos,$line)=each($lines)){
	$data=explode(":",$line);
	if ($data[0]==$user and $data[1]==md5($pass)){
	    echo "login OK<br>";
	    $_SESSION["logged"]=1;
	}
}
if ($_SESSION["logged"]==1){
	echo "<a href=session.php>Get busy</a>";
}
else{
	echo "login failed<br>";
	session_unset();
	session_destroy();
}
}
?>
