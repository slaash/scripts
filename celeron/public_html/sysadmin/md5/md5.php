<html>
<title>
Just for fun MD5 !
</title>
<body>
<form action=md5.php method=post>
String: <input type=text name=str>
<input type=submit value="Hash it !">
</form>
<hr>
<?php
if (count($_POST)!=0){
    echo md5($_POST['str'])."<br>";
}
?>
<a href=../index.php>Inapoi</a>
</body>
</html>
