<?php
$timestmp=time();
$file="test";
if (preg_match("/(.*)\.(.*)/",$file,$matches)){
	print $matches[1]." ".$matches[2]."\n";
	$file=$matches[1]."_".$timestmp.".".$matches[2];
}
else{
	$file=$file."_".$timestmp;
}
echo $file."\n";
?>

