<?php
echo "<b>Calculator numere prime</b><br><br>";
echo "<form action=calc.php method=post>";
echo "De la: <input type=text name=de_la>";
echo " Pana la: <input type=text name=pana_la>";
echo " <input type=submit value=Calculeaza><br><br>";
echo " <input type=checkbox name=unique>Verific un singur numar (primul)<P>";
echo "</form>";
$min=$_POST['de_la'];
if (isset($_POST['unique'])){
    $max=$min;
}
else{
    $max=$_POST['pana_la'];
}
if (is_numeric($min) and is_numeric($max)){
if (strlen($min)!=0 and strlen($max)!=0){
if ($max-$min>1000){
    echo "Interval prea mare (>1000)";
}
else{
    if (isset($_POST['unique'])){
	echo "Verific daca ".$min." e prim.<br>";
    }
    else{
	echo "Calculez numerele prime dintre <b>".$min."</b> si <b>".$max."</b>.<br>";
    }
    $started=date("h:m:s A");
    echo "Inceput la: ".$started."<hr>Am gasit: ";
    for ($i=$min;$i<=$max;$i++){
        $prim=1;
        for ($j=2;$j<=sqrt($i);$j++){
	    if ($i % $j==0){
		$prim=0;
		break;
	    }
	}
	if ($prim==1){
	    echo $i." ";
	}
    }
    $finished=date("h:m:s A");
    echo "<hr>Sfarsit la: ".$finished;
}
}
}
?>
