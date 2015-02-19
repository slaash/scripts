<?php
header("Content-type: image/png");
$im=@imagecreate(641,481);
$background_color=imagecolorallocate($im,200,200,200);
$text_color=imagecolorallocate($im,255,0,0);
$line_color=imagecolorallocate($im,0,0,255);
imagestring($im,5,0,0,"Hello, world !",$text_color);
for ($i=30;$i<=480;$i=$i+10)
    imageline($im,0,$i,640,$i,$line_color);
for ($i=0;$i<=640;$i=$i+10)
    imageline($im,$i,30,$i,480,$line_color);
imagepng($im);
imagedestroy($im);
?>
