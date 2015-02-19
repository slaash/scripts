#!/usr/bin/perl

use strict;
use warnings;

use IPC::Shareable;

my $x;
my %options = (
	create    => 0,
	exclusive => 0,
	mode      => 0644,
	destroy   => 0,
);

my $key=$ARGV[0];
chomp $key;
print "Key: $key\n";

tie $x,'IPC::Shareable',$key,{%options} or die "client tie error!";

print "$x\n";

exit;

