#!/usr/bin/perl

use Digest::MD5 qw(md5_hex);

print md5_hex($ARGV[0]);
print "\n";

