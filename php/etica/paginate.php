<?php

$pagenum=$_REQUEST['pagenum'];
$selected_quiz=$_REQUEST['selected'];

$PERPAGE=10;

$db=mysql_connect("localhost","uidl9555","pass1234");
mysql_select_db("uidl9555_db");

$query="select count(distinct timestamp) from answers";
$result=mysql_query($query);

$COMPLETED=mysql_result($result,0,0);

$PAGES=ceil($COMPLETED/$PERPAGE);

if (!(isset($pagenum))){
	$pagenum = 1; 
} 

if ($pagenum < 1){
	$pagenum = 1; 
} 
elseif ($pagenum > $PAGES){
	$pagenum = $PAGES; 
} 

$MAX = 'limit ' .($pagenum - 1) * $PERPAGE .',' .$PERPAGE; 
?>

<table border='1' cellspacing='0'>

<?php
$query="select distinct timestamp from answers $MAX";
$result=mysql_query($query);
while ($row=mysql_fetch_array($result,MYSQL_ASSOC)){
	if ($row["timestamp"]==$selected_quiz){
		$query="select timestamp,question_id,answer from answers where timestamp=$selected_quiz order by question_id";
		$result1=mysql_query($query);
		echo "<tr>";
		echo "<td><b>".date('d M Y  H:i:s',$row["timestamp"])."</b></td>";
		echo "</tr>";
		echo "<tr>";
		echo "<td>";
		echo "<table border='1' cellspacing='0'>";
		while ($row=mysql_fetch_array($result1,MYSQL_ASSOC)){
			echo "<tr>";
			$query="select question from questions where id='".$row["question_id"]."'";
			$result2=mysql_query($query);
			$qtext=mysql_result($result2,0,0);
			echo "<td>".$qtext."</td>";
			echo "<td>".$row["answer"]."</td>";
			echo "</tr>";
		}
		echo "</table>";
		echo "</td>";
		echo "</tr>";
	}
	else{
	        echo "<tr><td>";
	        echo "<a href='http://iasp209x/~uidl9555/etica/paginate.php?pagenum=".$pagenum."&selected=".$row["timestamp"]."'>".date('d M Y  H:i:s',$row["timestamp"])."</a>";
        	echo "</td></tr>";
	}
}
?>

</table>

<?php
echo "<a href='http://iasp209x/~uidl9555/etica/paginate.php?pagenum=".($pagenum-1)."'>Prev</a>";
echo "&nbsp;";
echo "<a href='http://iasp209x/~uidl9555/etica/paginate.php?pagenum=".($pagenum+1)."'>Next</a>";
mysql_close($db);
?>

