#!/usr/bin/perl

use strict;
use warnings;

use IPC::Mmap::Share;

#my $ref = IPC::Mmap::Share->new(10000);

while (<STDIN>){
	chomp $_;
	my $var=$_;
	$ref->set($var);
}

