<?php
$x=$_POST['poza_x'];
$y=$_POST['poza_y'];
if ($x>115 and $x<343 and $y>95 and $y<163){
    header("Location: primes/calc.php");
}
elseif ($x>505 and $x<704 and $y>97 and $y<184){
    header("Location: md5/md5.php");
}
elseif ($x>136 and $x<420 and $y>304 and $y<381){
    header("Location: login/login.html");
}
elseif ($x>501 and $x<704 and $y>374 and $y<463){
    header("Location: guestbook/gb.html");
}
elseif ($x>111 and $x<291 and $y>451 and $y<535){
    header("Location: webshell/webshell.php");
}
else{
    header("Location: index1.html");
}
?>
