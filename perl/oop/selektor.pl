#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Getopt::Long;

use selektor;

my @list;

sub displayList{
	for (@_){
		print "$_ ";
	}
	print "\n";
}

sub buildList{
	push(@list,$_[0]);
}

sub help{
	print "Usage: ./selektor.pl <options> <list of names>
		-v: verbose mode
		-p: gets input from a pipe. E.g. cat file.txt|./selektor.pl -p
		It will also set verbose mode (no user input)
		-h: this message
";
	exit;
}

my $debug=0;
my $pipe=0;
GetOptions("v" => \$debug,#sets it to 1 if present
		"p" => \$pipe,#get input from a pipe
		"h" => \&help,#usage info
		"<>" => \&buildList);#all non-option arguments are processed this way

if ($pipe == 1){
	while (<STDIN>){
		chomp $_;
		&buildList("$_");
	}
	$debug=1;
}

system("clear");

my $x=new selektor($debug,@list);
$x->genPairs();
exit;

for (@list){
	print "Full list: ";
	&displayList(@list);
	print "\t$_ extracts...(press a key to extract) ";
	if ($debug == 0){
		<STDIN>;
		print "\t";
	}
	print $x->remRandName($_)."\n";
	if ($debug == 1){
		print "Remains:   ";
		&displayList($x->getNames());
	}
	if ($debug == 0){
		print "Press a key to continue...\n";
		<STDIN>;
		system("clear");
	}

}

