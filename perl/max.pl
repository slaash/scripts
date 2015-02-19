#!/usr/bin/perl

use strict;
use warnings;

my @num=("450","450");

sub max{
	if ($_[0]<$_[1]){
		return $_[1];
	}
	else{
		return $_[0];
	}
}

my $max=$num[0];
for (@num){
	$max=max($max,$_);
}

print $max;

