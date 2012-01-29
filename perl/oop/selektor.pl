#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Getopt::Long;

use selektor;

my @list=("Gigi","Vali","Simi","Mimi","Fifi");

sub displayList{
	for (@_){
		print "$_ ";
	}
	print "\n";
}

my $debug=0;
GetOptions("verbose" => \$debug);#sets it to 1 if present

system("clear");

my $x=new selektor($debug,@list);

for (@list){
	print "Full list: ";
	&displayList(@list);
	print "\t$_ extracts... ";
	if ($debug == 0){
		<>;
		print "\t";
	}
	print $x->remRandName($_)."\n";
	if ($debug == 1){
		print "Remains:   ";
		&displayList($x->getNames());
	}
	if ($debug == 0){
		print "Press a key to continue...\n";
		<>;
		system("clear");
	}
	
}

