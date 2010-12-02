<html>
<body>
<form action=user_create.php method=post>
Nume:<input type=text name=nume><br>
Username:<input type=text name=user><br>
Password:<input type=password name=pass><br>
<input type=submit value=Save>
</form>
<?php
$nume=$_POST['nume'];
$user=$_POST['user'];
$pass=$_POST['pass'];
if (strlen($nume)!=0 and strlen($user)!=0 and strlen($pass)!=0){
if (file_exists("user.txt")){
    $contents=file_get_contents("user.txt");
    $lines=explode("/",$contents);
    $existent=0;
    while (list($pos,$line)=each($lines)){
        $data=explode(":",$line);
        if ($data[0]==$user){
	    $existent=1;
	}
    }
    if ($existent==0){
	$file=fopen("user.txt","a");
	fwrite($file,$user);
	fwrite($file,":");
	fwrite($file,md5($pass));
	fwrite($file,":");
	fwrite($file,$nume);
	fwrite($file,"/");
	fclose($file);
	echo "<a href=user_login.php>Intra in cont</a><br><br>";
    }
    else{
	echo "user deja existent<br>";
    }
}
else{
    echo "user database missing<br>";
}
}
?>
</body>
</html>
