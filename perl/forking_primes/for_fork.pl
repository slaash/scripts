#!/usr/bin/perl

use strict;
use warnings;

my $parallel = 6;
my $running=0;
my $result;

for my $i (1..10){
	my $pid=fork;
	if ($pid==0){
		print "$i\n";
		last;
	}
	else {
                $running++;
                print localtime() . ": child pid $pid spawned, $running running\n";
                if ($running >= $parallel) {
                        $result = wait;
                        $running--;
                        print localtime() . ": child pid $result completed, $running running\n";
                }
        }
}

until (($result = wait) == -1) {
        $running--;
        print localtime() . ": child pid $result completed, $running running\n";
}
