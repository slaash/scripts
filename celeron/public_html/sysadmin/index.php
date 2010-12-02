<html>
<head>
<title>radu@localhost:~$ </title>
<meta name="Title" content="radu moisa's homepage">
<meta name="Description" content="radu moisa's homepage">
<meta name="Keywords" content="inginer de sistem, sysadmin, administrator de retea, retea, calculatoare">
</head>
<body bgcolor="black" text="white" link="white" vlink="gray">
<center>
<br/>
<?php
echo "<table width='800' border='0'>";
echo "<tr><td>"; 
echo "<p align=right>".date("D, d M Y, h:i:s A")."</p>";
echo "</td></tr>";
$file=fopen("visitors.txt","a");
fwrite($file,date("d M Y, H:i:s"));
fwrite($file,"|");
fwrite($file,$_SERVER['REMOTE_ADDR']);
fwrite($file,"|");
fwrite($file,gethostbyaddr($_SERVER['REMOTE_ADDR']));
fwrite($file,"|");
fwrite($file,$_SERVER['HTTP_USER_AGENT']);
fwrite($file,"\n");
fclose($file);
?>
</table>
<br />
<table width="800" border="1" cellspacing="0">
    <tr bgcolor="gray">
	<td width="500">
	    <font color="white"><b><i>Chestii si treburi:</i></b></font>
	</td>
	<td width="300">
	    <font color="white"><b><i>Alte lucruri (linkuri ?!):</i></b></font>
	</td>
    </tr>
    <tr>
	<td>
	    <br />
	    <a href="primes/calc.php"  style="text-decoration: none"     >[ <b>Prime numbers</b> ]</a><br>
	    <a href="webshell/webshell.php" style="text-decoration: none">[ <b>WebShell</b> ]</a><br>
	    <a href="login/login.html" style="text-decoration: none"     >[ <b>General purpose login manager :)</b> ]</a><br>
	    <a href="guestbook/gb.html" style="text-decoration: none"    >[ <b>Guestbook</b> ]</a><br>
	    <a href="md5/md5.php" style="text-decoration: none"          >[ <b>MD5 hash</b> ]</a><br/>
	    <br />
	</td>
	<td>
	    <a href="http://www.insecure.org/nmap/" style="text-decoration: none" target="_blank"><font color="red"><b>nmap</b></font> - cel mai bun browser de la utp incoace !</a>
	    <br/>
	    <a href="http://tor.eff.org/" style="text-decoration: none" target="_blank"><font color="red"><b>tor</b></font> - safe hacks !</a>
	    <br />
	</td>
    </tr>
    <tr bgcolor="gray">
	<td>
	    <font color="white"><b><i>Lucruri fine:</i></b></font>	    
	</td>
	<td>
	    <font color="white"><b><i>Mai vedem (multumiri ! - nu, fast blog !:) - mda, probabil ultimele bloguri...):</i></b></font>	    
	</td>
    </tr>
    <tr>
	<td>
	    <br />
	    <a href="sounds/list.php" style="text-decoration: none"              >[ <b>Muzica</b> ]</a><br />
	    <a href="blog/blog.php" style="text-decoration: none" target="_blank">[ <b>/var/log/weblog</b> ]</a>
	    <br />
	    <br />
	</td>
	<td>
	    Imi multumesc ! Noul look e mult mai misto ca vechiul, care era de tot rahatul.<br />
	    Adica era functional, ba !<br />
	    Acu', serios, mai mult am vopsit gardul...<br /><br />
	    <b>P.S.</b> Daca tot retardatul are blog, eu de ce nu ?<br />
	    <b>P.P.S.</b> I FUCKING LIKE IT !
	    If you disagree, please die !<br />
	    <b>TO DO:</b> Sa pun niste poze !!!!! Trebe !!!! Toata lumea are !!!! Acum !!!
	</td>
    </tr>
</table>
<br />
<table width="800">
    <tr>
	<td>
	    <center>
	    <i><b>(c) 2006 radu moisa</b></i>
	    </center>
	</td>
    </tr>
    <tr>
	<td>
	<a href="http://www.uptime-project.net/profile.php?uid=106354" target="_blank"><img src="http://img.uptime-project.net/img/8/106354.png" alt="UPTIME: black_man - http://www.uptime-project.net" border="0"></a>
	</td>
    </tr>
</table>

</center>
</body>
</html>
