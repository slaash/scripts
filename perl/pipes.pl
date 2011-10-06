#!/usr/bin/perl

use strict;
use warnings;

use IO::Handle;               # thousands of lines just for autoflush :-(
pipe(PARENT_RDR, CHILD_WTR);  # XXX: check failure?
pipe(CHILD_RDR,  PARENT_WTR); # XXX: check failure?
CHILD_WTR->autoflush(1);
PARENT_WTR->autoflush(1);
my $pid;
if ($pid = fork()) {
	close PARENT_RDR; 
	close PARENT_WTR;
	print CHILD_WTR "Parent Pid $$ is sending this\n";
	chomp(my $line = <CHILD_RDR>);
	print "Parent Pid $$ just read this: '$line'\n";
	close CHILD_RDR; close CHILD_WTR;
	waitpid($pid, 0);
} else {
	die "cannot fork: $!" unless defined $pid;
	close CHILD_RDR; 
	close CHILD_WTR;
	chomp(my $line = <PARENT_RDR>);
	print "Child Pid $$ just read this: '$line'\n";
	print PARENT_WTR "Child Pid $$ is sending this\n";
	close PARENT_RDR; 
	close PARENT_WTR;
	exit(0);
}

