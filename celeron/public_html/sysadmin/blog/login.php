<?php
session_start();
$_SESSION["logged"]=0;
?>
<html>
<head>
<title>
Administrare blog
</title>
</head>
<body bgcolor="black" text="white" link="white" vlink="gray">
<form action=login.php method=post>
Username:<input type=text name=user><br>
Password:<input type=password name=pass><br>
<input type=submit value=Login>
</form>
<?php
$user=htmlentities($_POST['user']);
$pass=htmlentities($_POST['pass']);
if (strlen($user)!=0 and strlen($pass)!=0){
    if ($user=="radu" and md5($pass)=="175e8f89ce88d5163863bf67cf4e61fc"){
	    $_SESSION["logged"]=1;
	    echo "login ok, <a href='new.php'>continue...</a><br/>";
    }
    else{
	echo "login failed<br>";
	session_unset();
	session_destroy();
    }
}
?>
</body>
</html>
