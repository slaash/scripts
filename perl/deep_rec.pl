#!/usr/bin/perl

use strict;
use warnings;

my $count=0;

sub do_stuff{
	$count++;
	if ($count<200){
		&do_stuff();
	}
}

&do_stuff();

print "Gata!\n";

