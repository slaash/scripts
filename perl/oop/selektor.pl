#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use selektor;

my @list=("Gigi","Vali","Simi","Mimi","Fifi");

sub displayList{
	for (@_){
		print " $_\n";
	}
}

my $x=new selektor(@list);
print "List:\n";
&displayList($x->getNames());

for (0..$#list){
	print "\tDeleted: ".$x->remRandName()."\n";
	print "New list:\n";
	displayList($x->getNames());
}

