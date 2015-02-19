<?php
$link=mysql_connect('192.168.0.2','hasduser','hasd');
mysql_select_db('hasd');
$rezultat=mysql_query("select value from data");
header("Content-type: image/png");
$im=@imagecreate(800,600);
$background_color=imagecolorallocate($im,192,192,192);
$text_color=imagecolorallocate($im,0,255,0);
$grid_color=imagecolorallocate($im,0,0,255);
$graph_color=imagecolorallocate($im,255,0,0);
for ($i=0;$i<800;$i=$i+10)
    imageline($im,$i,600,$i,0,$grid_color);
for ($i=0;$i<600;$i=$i+100)
    imageline($im,0,$i,800,$i,$grid_color);
$crt_x=0;
$crt_y=500;
while ($row=mysql_fetch_assoc($rezultat)){
    imagestring($im,5,$crt_x,$crt_y,$row["value"],$text_color);
    imageline($im,$crt_x,$crt_y,$crt_x+10,600-($row["value"]*100),$graph_color);
    imageline($im,$crt_x+1,$crt_y-1,$crt_x+10+1,600-($row["value"]*100)-1,$graph_color);
    $crt_x=$crt_x+10;
    $crt_y=600-($row["value"]*100);
}
mysql_close($link);
imagepng($im);
imagedestroy($im);
?>
