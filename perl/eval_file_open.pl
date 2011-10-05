#!/usr/bin/perl

use strict;
use warnings;

my $try=0;
my $file;
while($try<6){
	eval{
		open $file,">>","file.txt" or die;
	};
	if ($@){
		print "file not available yet...we try again in 10 sec...\n";
		sleep(10);
		$try++;
	}
	else{
		last;
	}
}
if ($try==6){
	print "file could not be open!\n";
}
else{
	print "file open at try #$try\n";
	close $file;
}

