#!/usr/bin/perl

use strict;
use warnings;

use DBI;
use Data::Dumper;

sub query{
	my $conn=$_[0];
	my $query=$_[1];
	my $sth=$conn->prepare("$query");
	$sth->execute();
	my @rows;
	while (my @row = $sth->fetchrow_array()){
		push(@rows,\@row);	
	}
	undef $sth;
	return @rows;
}

sub print_result{
	my @rows=@_;
	for my $row (@rows){
        	for (@$row){
               		print "$_|";
        	}
        	print "\n";
	}
}

my $dbh=DBI->connect("dbi:SQLite:dbname=../db/test.db","","");

&print_result(&query($dbh,"select sqlite_version()"));

&print_result(&query($dbh,"select * from users"));



#print Dumper @users;

$dbh->disconnect;

