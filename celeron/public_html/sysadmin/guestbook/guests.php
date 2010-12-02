<?php
session_start();
?>
<html>
<title>
Guestbook viewer
</title>
<body>
<?php
if ($_SESSION['logged']==1){
$db=mysql_connect("localhost","sysadmin_04","nokia13");
mysql_select_db("sysadmin_04");
if (count($_POST)!=0){
    foreach($_POST as $key=>$value){
	$query="delete from guestbook where id={$key}";
	mysql_query($query);

    }
}
$query="select * from guestbook order by stamp desc";
$result=mysql_query($query);
echo "<form action=guests.php method=post>";
echo "<table border=1>";
echo "<tr>";
echo "<td>Marcheaza pentru stergere</td>";
echo "<td>Data si ora</td>";
echo "<td>IP</td>";
echo "<td>Header</td>";
echo "<td>Vizitator</td>";
echo "<td>Mesaj</td>";
echo "</tr>";
while ($row=mysql_fetch_array($result,MYSQL_ASSOC)){
    echo "<tr>";
    echo "<td><input type=checkbox name=".$row["id"].">Sterge</td>";
    echo "<td>".$row["stamp"]."</td>";
    echo "<td>".$row["ip"]." / ".gethostbyaddr($row["ip"])."</td>";
    echo "<td>".$row["header"]."</td>";
    echo "<td>".$row["name"]."</td>";
    echo "<td>".$row["message"]."</td>";
    echo "</tr>";
}
echo "<table>";
echo "<input type=submit value=Commit>";
echo "</form>";
mysql_free_result($result);
mysql_close($db);
}
else{
    echo "Nu esti autorizat !";
    session_unset();
    session_destroy();
}
?>
<hr>
<a href=gb.html>Inapoi</a>
</body>
</html>
