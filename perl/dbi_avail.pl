#!/usr/bin/perl

use DBI;

my @drivers = DBI->available_drivers();
print "Drivers: ";
for (@drivers){
	print "$_; ";
}
print "\n";
