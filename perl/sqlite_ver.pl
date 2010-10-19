#!/usr/bin/perl

use strict;
use warnings;

use DBI;
use Data::Dumper;

my $dbh=DBI->connect("dbi:SQLite:dbname=:memory:","","");

my $array_ref = $dbh->selectrow_arrayref("select sqlite_version()");
print "Version: $array_ref->[0]\n";

$dbh->disconnect;

