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
	$ret.="+-----------------+";
	chomp $ret;
	return $ret;
}

print &get_used_mem."\n";

use IO::File;

print &get_used_mem."\n";

use Digest::MD5;

print &get_used_mem."\n";

do "./subs.pl";

print &get_used_mem."\n";

