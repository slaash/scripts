#!/usr/bin/perl

use Benchmark;

sub show_ten{
	my $cnt=0;
	while($cnt<1000000){
		$cnt++;
	}
}

timethis(1000,&show_ten);

