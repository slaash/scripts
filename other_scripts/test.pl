#!/usr/local/bin/perl

use strict;
use warnings;

my $date=localtime;
my $str="+++++$date mama";
if ($str=~/mama/){
	print "matched\n";
}
else{
	print "not matched\n";
}

print "$str\n";

