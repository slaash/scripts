#!/usr/bin/perl

use strict;
use warnings;

open my $f1,$ARGV[0];
open my $f2,$ARGV[1];
while (my $line_f1=<$f1> and my $line_f2=<$f2>){
	chomp $line_f1;
	chomp $line_f2;
	print "$line_f1 - $line_f2\n";
}
close $f1;
close $f2;
