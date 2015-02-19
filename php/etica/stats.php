<?php
$db=mysql_connect("localhost","uidl9555","pass1234");
mysql_select_db("uidl9555_db");

$query="select id,question,type from questions";
$result=mysql_query($query);

echo "<table border='1' cellspacing='0'>";
while ($row=mysql_fetch_array($result,MYSQL_ASSOC)){
                echo "<tr><td>\n";
                echo $row["id"];
		echo "</td>\n";
                echo "<td>\n";
                echo $row["question"];
                echo "</td>\n";
		echo "<td>\n";
		if ($row["type"]=="yesno"){
			echo "<table border='1' cellspacing='0'>";
			$query="select count(question_id) from answers where question_id='".$row["id"]."' and answer='da'";
			$result1=mysql_query($query);
			$da=mysql_result($result1,0,0);
			$query="select count(question_id) from answers where question_id='".$row["id"]."' and answer='nu'";
			$result1=mysql_query($query);
                        $nu=mysql_result($result1,0,0);
			echo "<tr><td>".$da."</td><td>".$nu."</td></tr>";
			echo "</table>";
		}
                if ($row["type"]=="scale"){
                        $query="select count(question_id) from answers where question_id='".$row["id"]."' and answer='1'";
                        $result1=mysql_query($query);
                        $a=mysql_result($result1,0,0);
                        $query="select count(question_id) from answers where question_id='".$row["id"]."' and answer='2'";
                        $result1=mysql_query($query);
                        $b=mysql_result($result1,0,0);
                        $query="select count(question_id) from answers where question_id='".$row["id"]."' and answer='3'";
                        $result1=mysql_query($query);
                        $c=mysql_result($result1,0,0);
                        $query="select count(question_id) from answers where question_id='".$row["id"]."' and answer='4'";
                        $result1=mysql_query($query);
                        $d=mysql_result($result1,0,0);
                        $query="select count(question_id) from answers where question_id='".$row["id"]."' and answer='5'";
                        $result1=mysql_query($query);
                        $e=mysql_result($result1,0,0);
                        echo "1:".$a." 2:".$b." 3:".$c." 4:".$d." 5:".$e;
                }
		echo "</td></tr>\n";
}
echo "</table>";
mysql_close($db);
?>

