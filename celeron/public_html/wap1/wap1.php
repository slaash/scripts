<?php 
// send wml headers
header("Content-type: text/vnd.wap.wml"); 
echo "<?xml version=\"1.0\"?>"; 
echo "<!DOCTYPE wml PUBLIC \"-//WAPFORUM//DTD WML 1.1//EN\"" 
   . " \"http://www.wapforum.org/DTD/wml_1.1.xml\">";
?>

<wml>
<card id="card1" title="Example 1">
  <p>
    <?php 
// format and output date
    $the_date = date("M d Y");
    print $the_date;
    print "<br/>Welcome to a PHP-enabled site!";
    echo "<br/><input type='submit' name='name' value='hello world'/>";
    ?>
  </p>
</card>
</wml>
