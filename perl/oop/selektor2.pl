#!/usr/bin/perl

use strict;
use warnings;

use selektor2;

my $x=new selektor(("a","b","c","d","e"));
$x->shuffleArray();
my @orig=$x->getNames();
$x->shiftArray();
my @pair=$x->getNames();

for (my $i=0;$i<=$#orig;$i++){
	print "$orig[$i] => $pair[$i]\n";
}
