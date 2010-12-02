<html>
<head>
<title>De aici luati muzica</title>
</head>
<body>
<?php
$d = dir("./");
while ($file=$d->read()){
    if ($file!="list.php" and $file!="." and $file!= ".."){
	echo "<a href='".$file."'>".$file."</a><br/>";
    }
}
$d->close();
?>
</body>
</html>
