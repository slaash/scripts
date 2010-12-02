<html>
<head>
<title>
Test Page
</title>
</head>
<body>
<form action=test1.php method=post>
Nume: <input type=text name=nume><br>
Parola: <input type=text name=pass><br>
Mesaj: <textarea rows=10 cols=40 name=mesaj></textarea><br>
<input type=submit value=Trimite>
</form>
<hr>
<?php
if ($_POST['pass']=="mama"){
    echo "parola ok !";
}
else{
    echo "eroare parola...";
}
?>
<br>
<?php
echo $_POST['nume'];
?>
<br>
<?php
echo $_POST['mesaj'];
?>
<hr>
</body>
</html>


