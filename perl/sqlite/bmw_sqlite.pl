#!/usr/bin/perl

use strict;
use warnings;

use DBI;

sub query{
	my $conn=$_[0];
	my $query=$_[1];
	my $sth;
	my $array_ref;
	my @ret_array;
	eval{
		$sth=$conn->prepare("$query");
		$sth->execute();
		$array_ref=$sth->fetchall_arrayref();
	}; 
	if ($@){
		print "Error in query: $query!\n";
	}
	else{
		my $rows_found=$#$array_ref+1;
		if ($rows_found>0){
#			for my $arr ($array_ref){
#				for my $a (@$arr){
#					for (@$a){
#						print "$_\t";
#					}
#					print "\n";
#				}
#			}
#			print "Returned $rows_found rows.\n";
			return @$array_ref;
		}
	}
}

my $basedir="./";

my $dbh = DBI->connect("dbi:SQLite:dbname=".$basedir."/bmw_ids.db","","");
&query($dbh,"select sqlite_version()");

&query($dbh,"drop table bmw_ids");

&query($dbh,"create table bmw_ids(id INTEGER PRIMARY KEY,conti_id TEXT,bmw_id INTEGER)");

&query($dbh,"select * from bmw_ids");

open FILE,"$basedir/bmw_ids.txt";

while (my $line=<FILE>){
	chomp $line;
	my @l=split(/,/,$line);
	my @found_ids=&query($dbh,"select * from bmw_ids where bmw_id='".$l[1]."'");
#	print "Cu asta comparam: ".$#found_ids."\n";
	if ($#found_ids>=0){
		print "Updating $l[0] -> $l[1]\n";
		&query($dbh,"update bmw_ids set conti_id='".$l[0]."' where bmw_id='".$l[1]."'");
	}
	else{
		print "Inserting $l[0] -> $l[1]\n";
		&query($dbh,"insert into bmw_ids(conti_id,bmw_id) values ('".$l[0]."',".$l[1].")");
	}
}
close(FILE);

&query($dbh,"select * from bmw_ids");

$dbh->disconnect;

