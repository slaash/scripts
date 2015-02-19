#!/usr/bin/perl

use strict;
use warnings;

use IPC::Mmap::Share;

my $ref = IPC::Mmap::Share->new(10000);

my $var="Server ready!";
$ref->set($var);

my $last_var="";
while (1){
	$var=$ref->get;
	if ($var ne $last_var){
		$last_var=$var;
		print "$var\n";
	}
}

