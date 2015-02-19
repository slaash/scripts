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

$parallel=5;
$running=0;

for ($i=$min;$i<=$max;$i++){
	$pid=pcntl_fork();
	if ($pid==0){
		is_prime($i);
		exit;
	}
	else{
		$running++;
		if ($running>=$parallel){
			pcntl_wait($status);
			$running--;
		}
	}
}

while (pcntl_wait($status)!=-1){}
?>

