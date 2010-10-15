#!/usr/bin/perl

use strict;
use warnings;

use DBI;

my $dbh = DBI->connect("dbi:SQLite:dbname=test.db","","");
my $stmt;
my $sth;

sub drop_table{
	my $db=$_[0];
	$sth=$dbh->prepare("drop table $db");
	if ($sth){
	        $sth->execute;
	}
}

sub select_all{
	my $db=$_[0];
        $sth=$dbh->prepare("select * from $db");
        $sth->execute;
        while (my @rez=$sth->fetchrow){
                for (@rez){
                        print "$_\t";
                }
                print "\n";
        }
}

sub delete_all{
	my $db=$_[0];
        my $sth=$dbh->prepare("delete from $db");
        $sth->execute;
}

sub create_bmw_ids_table{
	$stmt="CREATE TABLE bmw_ids(conti_id text primary key,bmw_id integer)";
	$sth=$dbh->prepare("$stmt");
	$sth->execute;
}

sub create_bmw_data_table{
        $stmt="CREATE TABLE bmw_data(conti_id text primary key,customers text ,free_listbox_b text,completion_due_date text)";
        $sth=$dbh->prepare("$stmt");
        $sth->execute;
}

sub create_bmw_data{
	open FILE,"data.txt";
        while (<FILE>){
                chomp $_;
                my @line=split(/@@@/,$_);
                $stmt="select count(*) from bmw_data where conti_id=".$dbh->quote($line[0]);
                $sth=$dbh->prepare("$stmt");
                $sth->execute;
                my $size=$sth->fetch()->[0];
#		print "size: $size\n";
                if ($size>0){
                        $stmt="update bmw_data set customers=".$dbh->quote($line[1]).",free_listbox_b=".$dbh->quote($line[2]).",completion_due_date=".$dbh->quote($line[3])." where conti_id=".$dbh->quote($line[0]);
                }
                else{
                        $stmt="insert into bmw_data(conti_id,customers,free_listbox_b,completion_due_date) values (".$dbh->quote($line[0]).",".$dbh->quote($line[1]).",".$dbh->quote($line[2]).",".$dbh->quote($line[3]).")";
                }
#                print "$stmt\n";
                my $sth=$dbh->prepare("$stmt");
                $sth->execute;
        }
        close FILE;
}

sub create_bmw_ids{
open FILE,"bmw_ids.txt";
        while (<FILE>){
                chomp $_;
                my @line=split(/,/,$_);
                $stmt="select count(*) from bmw_ids where conti_id=".$dbh->quote($line[0]);
                $sth=$dbh->prepare("$stmt");
                $sth->execute;
                my $size=$sth->fetch()->[0];
#                print "size: $size\n";
                if ($size>0){
                        $stmt="update bmw_ids set bmw_id=".$dbh->quote($line[1])." where conti_id=".$dbh->quote($line[0]);
                }
                else{
                        $stmt="insert into bmw_ids(conti_id,bmw_id) values (".$dbh->quote($line[0]).",".$dbh->quote($line[1]).")";
                }
#                print "$stmt\n";
                my $sth=$dbh->prepare("$stmt");
                $sth->execute;
        }
        close FILE;
}

#&drop_table("bmw_data");
#&drop_table("bmw_ids");

#&create_bmw_data_table;
#&create_bmw_ids_table;

#&delete_all("bmw_data");
&delete_all("bmw_ids");

#&create_bmw_data;
&create_bmw_ids;

#&select_all("bmw_data");
&select_all("bmw_ids");

$dbh->disconnect;
