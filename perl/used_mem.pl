#!/usr/bin/perl

use strict;
use warnings;

sub get_used_mem{
	my $ret="+-----------------+\n";
	open(my $file, '<' ,"/proc/$$/status");
	while (<$file>){
		chomp $_;
		if ($_ =~ /(^VmSize:(.+)$|^VmPeak:(.+)$|^Pid:(.+)$|^PPid:(.+)$|^Name:(.+)$|^SleepAVG:(.+)$|^Threads:(.+)$)/){
			$_=~s/\s+/ /;
			$ret.="$_\n";
		}
	}
	close($file);
	$ret.="+-----------------+\n";
#	chomp $ret;
	return $ret;
}

print "used mem ran sucessfully\n";

