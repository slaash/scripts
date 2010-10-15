#!/usr/bin/perl

use strict;
use warnings;

use IPC::Shareable;

my $var;
my %options = (
	create    => 'yes',
	exclusive => 0,
	mode      => 0644,
	destroy   => 'yes',
);

tie $var,'IPC::Shareable','10',{%options} or die "server tie error!!!";

$var="Server ready!";

my $last_var="";
while (1 and $var!~/^bye/){
	if ($var ne $last_var){
		$last_var=$var;
		print "$var\n";
	}
}
IPC::Shareable->clean_up_all;
exit;

