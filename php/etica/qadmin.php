<?php
$db=mysql_connect("localhost","uidl9555","pass1234");
mysql_select_db("uidl9555_db");

if (isset($_POST['qtext']) and isset($_POST['qtype'])){
        $qtext=htmlentities($_POST['qtext']);
        $qtype=htmlentities($_POST['qtype']);
}
if ($qtext != "" and $qtype!=""){
        $query="insert into questions(question,type) values('".$qtext."','".$qtype."')";
        mysql_query($query);
}

$query="select id,question,type from questions";
$result=mysql_query($query);
?>

<table border="1" cellspacing="0">
	<tr>
		<td>
			<b>ID</b>
		</td>
		<td>
			<b>Intrebare</b>
		</td>
		<td>
			<b>Tip raspuns</b>
		</td>
	</tr>

<?php
while ($row=mysql_fetch_array($result,MYSQL_ASSOC)){
		echo "<tr><td>\n";
		echo $row["id"];
		echo "</td><td>\n";
                echo $row["question"];
		echo "</td><td\n>";
		if ($row["type"] == "yesno"){
			echo "<input type=\"radio\" name=\"radio".$row["id"]."\" checked>Yes\n";
			echo "<input type=\"radio\" name=\"radio".$row["id"]."\">No\n";
		}
                if ($row["type"] == "scale"){
                        echo "<input type=\"radio\" name=\"radio".$row["id"]."\" checked>1\n";
                        echo "<input type=\"radio\" name=\"radio".$row["id"]."\">2\n";
			echo "<input type=\"radio\" name=\"radio".$row["id"]."\">3\n";
                        echo "<input type=\"radio\" name=\"radio".$row["id"]."\">4\n";
                        echo "<input type=\"radio\" name=\"radio".$row["id"]."\">5\n";
                }
		if ($row["type"] == "freetext"){
			echo "<textarea cols=\"40\" rows=\"5\"></textarea>\n";
		}
		echo "</td></tr>\n";
}
?>

</table>
<hr/>
<form method="POST" action="qadmin.php">
	<table border="0" cellspacing="0">
		<tr>
			<td><b>Intrebare noua</b><br/></td>
			<td><b>Tip intrebare</b></td></tr>
		<tr>
			<td><textarea cols="40" rows="5" name="qtext"></textarea><br/></td>
			<td>
				<select name="qtype">
					<option value="yesno">Yes/No</option>
					<option value="scale">Scara 1-5</option>
					<option value="freetext">Bloc de text</option>
				</select>
			</td>
		</tr>
	</table>
<br/>
<input type="submit" value="Salveaza">
</form>

<?php
mysql_close($db);
?>

