#!/usr/bin/perl

use strict;
use warnings;
use Switch;

my $line;
my @l;

sub process_data{
#	my $linie=$_[0];
#	my @l;
#	switch ($linie) {
#	case /(\w+):(\s)(\w+)(\s)(\w+):(\w+)/ { print "rule 1: "; @l=split(/:/,$linie); print "$l[1] "; }
#	else {}
#	}
	print "$_[0] ";
	print DUMP_FILE "$_[0] ";
}

open DUMP_FILE,">","parsed.txt";

open INPUT_FILE,"/space_2/mailsMCH.txt";
while ($line=<INPUT_FILE>){
	chomp $line;
	if ($line =~ /The user with the id/){
		@l=split(/:/,$line);
		print "\n$l[1]:";
		print DUMP_FILE "\n$l[1]:";
		next;
	}
        if ($line =~ /has requested for the hostname/){
                @l=split(/:/,$line);
                print "$l[1]:";
		print DUMP_FILE "$l[1]:";
		next;
        }
	if ($line=~/Harmonized Tools/ or $line=~/Non Harmonized Tools/ or $line=~/Evaluation Tools/ or $line=~/Other Tools/ or $line=~/Additional Remarks/ or $line=~/From/ or $line=~/Sent/ or $line=~/To/ or $line=~/Subject/  or $line=~/The user with the id/ or $line=~/working in Project/ or $line=~/has requested for the hostname/ or $line=~/the following software products/ or $line eq ""){
	next;
	}
	&process_data($line);
}
print "\n";
close INPUT_FILE;

close DUMP_FILE;

