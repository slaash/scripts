<?php
echo "Nume: ".$_POST['nume']."<br>";
echo "Username: ".$_POST['user']."<br>";
echo "Password encrypted: ".md5($_POST['pass'])."<br>";
if (file_exists("user.txt")){
	echo "Fisier deschis pentru completare";
	$file=fopen("user.txt","a");
}
else{
	$file=fopen("user.txt","w");
	echo "Fisier creat";
}
fwrite($file,$_POST['user']);
fwrite($file,":");
fwrite($file,md5($_POST['pass']));
fwrite($file,":");
fwrite($file,$_POST['nume']);
fwrite($file,"/");
fclose($file);
?>
