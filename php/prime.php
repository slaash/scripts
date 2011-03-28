#!/usr/bin/php
<?php
$min=$argv[1];
$max=$argv[2];

function is_prime($n){
        $prim=1;
        for ($j=2;$j<=round(sqrt($n));bcadd($j,1)){
		print "n: $n sqrt: ".round(sqrt($n))." j: $j\n";
                if (fmod($n,$j) == 0){
                        $prim=0;
                        break;
                }
        }
        if ($prim==1){
                print "$n\n";
        }
}

foreach (range($min,$max) as $i){
	is_prime($i);
}
?>

