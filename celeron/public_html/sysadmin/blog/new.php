<?php
session_start();
?>
<html>
<head>
<title>
New post
</title>
</head>
<body bgcolor="black" text="white" link="white" vlink="gray">
<br/>
<?php
if ($_SESSION["logged"]==1){
    $mesaj=htmlentities($_POST["mesaj"]);
    $mesaj=str_replace("\r\n","<br/>",$mesaj);
    if (!isset($_POST["seen"]) or strlen($mesaj)==0){
    echo <<<END
	<form method="POST" action="new.php">
	<center>
	<table border="1" cellspacing="0">
	    <tr>
	        <td>
		    <b>Mugetarea zilei:</b>
		</td>
	    </tr>
	    <tr>
		<td>
		    <textarea rows="30" cols="60" name="mesaj"></textarea>
		</td>
	    </tr>
	    <tr>
		<td>
		    <input type="submit" value="Save" />
		    <input type="hidden" name="seen" />
		</td>
	    </tr>
	</table>
	</center>
	</form>
END;
    }
    else{
	$db=mysql_connect("localhost","sysadmin_04","nokia13");
	mysql_select_db("sysadmin_04");
	$query="insert into blog(text) values('".$mesaj."')";
	mysql_query($query);
	mysql_close($db);
	#nu stiu cum salvez, dar dupa aia distrug tot !!!
	session_unset();
	session_destroy();
	echo "Mesaj salvat !<br/><br/>";
	echo "<a href='blog.php'>Inapoi la blog</a>";
	}
}
else{
    echo "... access denied ...<br/>";
}
?>
</body>
</html>