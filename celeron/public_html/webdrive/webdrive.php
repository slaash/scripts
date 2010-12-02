<html>
<head>
<title>
WebDrive
</title>
</head>
</body>
<center><h1>WebDrive</h1></center>
<i>Stocheaza un fisier pe server:</i>
<br><br>
<form enctype=multipart/form-data action=webdrive.php method=post>
<input type=hidden name=MAX_FILE_SIZE value=10000000>
Fisier: <input type=file name=fisier><br><br>
<input type=submit value=Trimite>
</form>
<?php
$tmp=$_FILES['fisier']['tmp_name'];
$file=$_FILES['fisier']['name'];
$error=$_FILES['fisier']['error'];
$size=$_FILES['fisier']['size'];
$type=$_FILES['fisier']['type'];
if ($file!=""){
if (move_uploaded_file($tmp,$file)){
    echo "Fisierul ".$file." stocat pe server.<br>";
    echo "Ocupa ".$size." bytes<br>";
    echo "Tip: ".$type."<br>";
}
else{
    echo "Eroare ".$error.".<br>";
}
}
?>
<hr>
<i>Fisierele de pe server:</i>
<br><br>
<form action=webdrive.php method=post>
<?php
$listing=scandir(".");
echo "<table border=1>";
echo "<tr><td><i><b>Sterge</b></i></td><td><b>Nume</b></td><td><b>Dimensiune</b></td></tr>";
foreach ($listing as  $i){
    if (is_file($i)){
	echo "<tr>";
	echo "<td>";
	echo "<input type=checkbox name=".current($listing).">";
	echo "</td>";
	echo "<td>";
        echo "<a href='".$i."'>".$i."</\a>";
	echo "</td>";
	echo "<td>";
	echo filesize($i)." Bytes";
	echo "</td>";
	echo "</tr>";
    }
}
echo "</table>";
?>
<input type=submit value=Commit>
</form>
</body>
</html>
