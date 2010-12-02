<?php 
// send wml headers
header("Content-type: text/vnd.wap.wml"); 
echo "<?xml version=\"1.0\"?>"; 
echo "<!DOCTYPE wml PUBLIC \"-//WAPFORUM//DTD WML 1.1//EN\"" 
   . " \"http://www.wapforum.org/DTD/wml_1.1.xml\">";
?>

<wml>
<card id="receiver" title="Receiver">
  <p>
    <?php 
	print "Hello<br/>";
	print "Aici vine numele: ".$Nume." pana aici<br/>";
	
    ?>
  </p>
</card>
</wml>
