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
#                print "$cmd returned $rows_found rows.\n";
                if ($rows_found>0){
#                        for my $arr ($array_ref){
#                                for my $a (@$arr){
#                                        for (@$a){
#                                                print "$_\t";
#                                        }
#                                        print "\n";
#                                }
#	                }
                        return @$array_ref;
                }
                else{
                        return undef;
                }
        }
#        else{
#                print "$cmd successfull.\n";
#        }
}

my $basedir="./";

my $dbh = DBI->connect("dbi:SQLite:dbname=".$basedir."/bmw_ids.db","","");
my @rez=&query($dbh,"select sqlite_version()");
print "$rez[0]->[0]\n";

&query($dbh,"drop table bmw_ids");

&query($dbh,"create table bmw_ids(id INTEGER PRIMARY KEY,conti_id TEXT,bmw_id INTEGER)");

#&query($dbh,"select * from bmw_ids");

open FILE,"$basedir/bmw_ids.txt";

my $cnt=0;
while (my $line=<FILE>){
	if ($cnt>1000){
		last;
	}
	chomp $line;
	my @l=split(/,/,$line);
	my @found_ids=&query($dbh,"select * from bmw_ids where bmw_id='".$l[1]."'");
	if ($found_ids[0]){
		print "Updating $l[0] -> $l[1]\n";
		&query($dbh,"update bmw_ids set conti_id='".$l[0]."' where bmw_id='".$l[1]."'");
	}
	else{
		print "Inserting $l[0] -> $l[1]\n";
		&query($dbh,"insert into bmw_ids(conti_id,bmw_id) values ('".$l[0]."',".$l[1].")");
	}
	$cnt++;
}
close(FILE);

#&query($dbh,"select * from bmw_ids");

$dbh->disconnect;

