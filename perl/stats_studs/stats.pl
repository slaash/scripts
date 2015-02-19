#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use DBI;

sub query{
	my $conn=$_[0];
	my $query=$_[1];
	my $sth;
	my $array_ref;
	my @ret_array;
	$query=~/(\w+)\s(.+)/;
	my $cmd=$1;
	eval{
		if ($cmd eq "select"){
			$sth=$conn->prepare("$query");
			$sth->execute();
			$array_ref=$sth->fetchall_arrayref();
		}
		else{
			$sth=$conn->do("$query");
		}
	}; 
	if ($@){
		print "Error in query: $query!\n";
	}
	elsif($array_ref){
		my $rows_found=$#$array_ref+1;
		print "$cmd returned $rows_found rows.\n";
		if ($rows_found>0){
			for my $arr ($array_ref){
				for my $a (@$arr){
					for (@$a){
						if ($_){
							print "$_\t";
						}
					}
					print "\n";
				}
			}
			return @$array_ref;
		}
		else{
			return undef;
		}
	}
	else{
		print "$cmd successfull.\n";
	}
}

my $basedir="./";

my $dbh = DBI->connect("dbi:mysql:uidl9555_db;host=localhost","uidl9555","aaa");

&query($dbh,"select version()");

&query($dbh,"select a.timestamp as tstamp,a.question_id as q_id ,q.text as q_text,q.position as q_pos,a.variant_id as var_id,a.comment as answer from answers a, questions q where a.question_id=q.id order by a.timestamp, q.position");

$dbh->disconnect;

