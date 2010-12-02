<?php
include("fck/fckeditor.php") ;
?>
<html>
<head>
<title>FCKeditor - Sample</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<form action="savedata.php" method="post">
<?php
$oFCKeditor = new FCKeditor('FCKeditor1') ;
$oFCKeditor->BasePath = 'fck/';
$oFCKeditor->Value = 'Default text in editor';
$oFCKeditor->Create() ;
?>
<br>
<input type="submit" value="Submit">
</form>
</body>
</html>
