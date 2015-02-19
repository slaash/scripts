#!/usr/bin/php
<?php
$min=$argv[1];
$max=$argv[2];

function is_prime($n){
        $prim=1;
        for ($j=2;$j<=bcsqrt($n);$j++){
#		print "n: $n sqrt: ".round(sqrt($n))." j: $j\n";
                if (bcmod($n,$j) == 0){
                        $prim=0;
                        break;
                }
        }
        if ($prim==1){
                print "$n\n";
        }
}

for ($i=$min;$i<=$max;$i++){
	is_prime($i);
}
?>

