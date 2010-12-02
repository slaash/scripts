<?php
$tstamp=time();
$link=mysql_connect('192.168.0.2','hasduser','hasd');
mysql_select_db('hasd');
mysql_query("insert into data(time,value) values(".$tstamp.",".$_POST['option'].")");
echo "Scris-am azi,".date("D, d M Y",$tstamp)." in mysql<br>";
mysql_close($link);
switch ($_POST['option']){
case '1':
    echo "Dragul meu, ai avut o zi a dracului de PROASTA ....<BR>";
    break;
case '2':
    echo "Ei, ai avut si tu o zi proasta.<BR>";
    break;
case '3':
    echo "Hai ca e mai bine, o zi buna !<BR>";
    break;
case '4':
    echo "Impresionant, ai avut o zi extraordinar de buna !!!<BR>";
    break;
}
?>
