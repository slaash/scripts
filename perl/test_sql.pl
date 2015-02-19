#!/usr/bin/perl

use strict;
use warnings;

use DBI;

my $user="pr_reports";
my $passwd="pr_reports";
my $hostname="vmm02.ia.ro.conti.de";
my $database="pr_reports";

my $dbh=DBI->connect( "DBI:mysql:database=$database;host=$hostname","$user", "$passwd", { 'RaiseError' => 1 } );

if ($dbh){
	print "Seems OK!\n";
}
else{
	print "No db conn\n";
}

$dbh->disconnect();

