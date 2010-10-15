#!/usr/bin/perl

use DBI;

my $dbh=DBI->connect("dbi:SQLite:dbname=test.db","","");
my $sth=$dbh->prepare("select * from users");

$sth->execute();

while (my @row = $sth->fetchrow_array()){
	for (@row){
		print "$_|";
	}
	print "\n";	
}

undef $sth;
$dbh->disconnect;

