#!/usr/bin/perl

for $i (0..10){
	for $j (0..10){
		$data[$j]=$j;
	}
	$array[$i]=\@data
}

for $i (@array){
	for $j (@$i){
		print $i->[$j]."\n";
	}
}

