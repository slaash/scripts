#!/usr/bin/perl

use strict;
use warnings;

use 5.010;

sub incr{
	state $i=0;
	return $i++;
}

say &incr x 10;

for (1..10){
	say &incr;
}

