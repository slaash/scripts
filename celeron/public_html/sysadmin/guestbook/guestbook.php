<html>
<title>Guestbook</title>
<body>
Aici poti sa lasi un mesaj frumos despre ce mult ti-a placut tie site-ul.<br><br>
<form action=guestbook.php method=post>
Nume: <input type=text size=45 name=nume><br>
Mesaj: <textarea rows=10 cols=40 name=mesaj></textarea><br>
<input type=submit value=OK>
</form>
<hr>
Uite, aici au scris ailalti:
<br><br>
<?php
$nume=$_POST['nume'];
$mesaj=$_POST['mesaj'];

$db=mysql_connect("localhost","sysadmin_04","nokia13");
mysql_select_db("sysadmin_04");

if (strlen($nume)!=0 and strlen($mesaj)!=0){
    $bad=array("<",">","'","\"","\\","/");
    $good=array("[","]","`","``","",":");
    $nume=str_replace($bad,$good,$nume);
    $mesaj=str_replace($bad,$good,$mesaj);
    $query="insert into guestbook(ip,header,name,message) values('".$_SERVER['REMOTE_ADDR']."','".$_SERVER['HTTP_USER_AGENT']."','".$nume."','".$mesaj."')";
    mysql_query($query);
}

$query="select * from guestbook order by stamp desc";
$result=mysql_query($query);
echo "<table border=1>";
echo "<tr>";
echo "<td>Data si ora</td>";
echo "<td>Vizitator</td>";
echo "<td>Mesaj</td>";
echo "</tr>";
while ($row=mysql_fetch_array($result,MYSQL_ASSOC)){
    echo "<tr>";
    echo "<td>".$row["stamp"]."</td>";
    echo "<td>".$row["name"]."</td>";
    echo "<td>".$row["message"]."</td>";
    echo "</tr>";
}
echo "<table>";
mysql_free_result($result);
mysql_close($db);
?>
<hr>
<a href=gb.html>Inapoi</a>
</body>
</html>