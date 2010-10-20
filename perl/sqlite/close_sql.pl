#!/PROJ/cis/gen/general/sun_utils/gnu/sun4/bin.solaris/perl

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

my $basedir="/HOME/ccm_wet/local/scripts/sqlite";

my $dbh = DBI->connect("dbi:SQLite:dbname=".$basedir."/bmw_ids.db","","");
&query($dbh,"select sqlite_version()");

$dbh->disconnect;

