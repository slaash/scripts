#!/usr/bin/perl

use strict;
use warnings;
use IO::File;
use Data::Dumper;

sub store_var{
	my $var_name=$_[0];
	my $var_val=$_[1];
	my $shm_file=new IO::File;
	$shm_file->binmode;
	$shm_file->open("> /dev/shm/$var_name");
	print $shm_file $var_val;
	$shm_file->close;
}

sub get_var{
	my $var_name=$_[0];
	my $var_val="";
	my $shm_file=new IO::File;
	$shm_file->binmode;
	$shm_file->open("< /dev/shm/$var_name");
	$var_val=<$shm_file>;
	$shm_file->close;
	return $var_val;
}

my $arr;
$arr->[0]=1;
$arr->[1]=2;
$arr->[2]=3;

&store_var("arr",$arr);
my $arr1=&get_var("arr");

print $arr1->[0]."\n".$arr1->[1]."\n".$arr1->[2];

