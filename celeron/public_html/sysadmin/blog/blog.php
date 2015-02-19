<html>
<head>
<title>
Jurnalul lui Radu
</title>
</head>
<body text="white" bgcolor="black" link="white" vlink="gray">
<br>
<?php
$db=mysql_connect("localhost","sysadmin","nokia13");
mysql_select_db("sysadmin_04");
?>
<center>
<table border="1" cellspacing="0">
    <tr>
	<td width="500">
		<h1>Jurnalul lui Radu</h1>
		<p align="right">"<i>"Aici va fi un motto"</i></p>
		<br/>
	</td>
	<td width="200">
		<center>
		<i><b>Administrare weblog</b></i>
		<br/><br/>
		<a href="login.php" style="text-decoration: none"><b>[ Login ]</b></a>
		</center>
	</td>
    </tr>
    <tr>
	<td>
	    <?php
	    if (isset($_REQUEST["id"])){
    		$query="select unix_timestamp(date) as data,text from blog where id=".$_REQUEST["id"];
	    }
	    else{
    		$query="select unix_timestamp(date) as data,text from blog order by date desc limit 1";
	    }
	    $result=mysql_query($query);
	    while ($row=mysql_fetch_array($result,MYSQL_ASSOC)){
		echo "<p align='right'><b><i>".date("l, g:i:s A",$row["data"])."&nbsp;</i></b></p><br/>";
		echo $row["text"]."<br/>";
	    }
	    ?>			    
    	</td>
	<td>
	    <center>
	    <i><b>Posturi anterioare</b></i>
	    <br/><br/>
	    </center>
	    <?php
    	    $query="select id,unix_timestamp(date) as data from blog order by date desc";
	    $result=mysql_query($query);
	    while ($row=mysql_fetch_array($result,MYSQL_ASSOC)){
		echo "<a href='blog.php?id=".$row["id"]."' style='text-decoration: none'><b>".date("l, j F Y",$row["data"])."</b></a><br/><br/>";
	    }
	    ?>			    
	</td>
    </tr>
</table>
</center>
<?php
mysql_close($db);
?>
</body>
</html>
