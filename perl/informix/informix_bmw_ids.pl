#!/usr/bin/perl -I/opt/IBM/informix/lib/esql

use strict;
use warnings;

use DBI;
use Data::Dumper;

$ENV{"INFORMIXDIR"}="/opt/IBM/informix";
$ENV{"INFORMIXSERVER"}="test";
$ENV{"ONCONFIG"}="test";
$ENV{"PATH"}=$ENV{"INFORMIXDIR"}."/bin:".$ENV{"PATH"};
#$ENV{"DBD_INFORMIX_RELOCATABLE_INFORMIXDIR"}="yes";

my $dbh=DBI->connect("dbi:Informix:radu_test");
my $sth;
my $stmt;
my @rez;

sub select_all{
	my $sth=$dbh->prepare("select * from bmw_ids");
	$sth->execute;
	while (my @rez=$sth->fetchrow){
		for (@rez){
			print "$_\t";
		}
        	print "\n";
	}
}

sub delete_all{
        my $sth=$dbh->prepare("delete from bmw_ids");
        $sth->execute;
}

sub debug_info{
	my @tables=$dbh->func('user','_tables');
	my @cols = $dbh->func(@tables, '_columns');
	for (@tables){
		print "$_\n";
	}
	for my $item (@cols){
		for (@$item){
			print "$_\t";
		}
	print "\n";
	}
}

sub create_data{
open FILE,"bmw_data/bmw_ids.txt";
	while (<FILE>){
		chomp $_;
		my @line=split(/,/,$_);
		$stmt="select count(*) from bmw_ids where conti_id=".$dbh->quote($line[0]);
		$sth=$dbh->prepare("$stmt");
		$sth->execute;
		my $size=$sth->fetch()->[0];
		print "size: $size\n";
		if ($size>0){
			$stmt="update bmw_ids set bmw_id=".$dbh->quote($line[1])." where conti_id=".$dbh->quote($line[0]);
		}
		else{
			$stmt="insert into bmw_ids(conti_id,bmw_id) values (".$dbh->quote($line[0]).",".$dbh->quote($line[1]).")";
		}
		print "$stmt\n";
		my $sth=$dbh->prepare("$stmt");
		$sth->execute;
	}
	close FILE;
}

#&delete_all;
&select_all;

$dbh->disconnect;

