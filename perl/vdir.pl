#!/usr/bin/perl

use strict;
use warnings;

use File::stat;
use File::Find;
use POSIX qw(strftime);
use Switch;

use Data::Dumper;

my %files_by_modify_time;
my %files_by_size;

sub check_files{
	my $file=$_;
	my $dir=$File::Find::dir;
	chdir $dir;
	if (-f $_){
		$files_by_modify_time{"$dir/$file"}=(stat($_))->[9];
		$files_by_size{"$dir/$file"}=(stat($_))->[7];
	}
}

sub sort_by_modify_time{
	my (%files)=%{$_[0]};
	for (sort { $files{$a} <=> $files{$b} } keys %files){
       		print strftime("%Y/%m/%d %H:%M:%S",localtime($files{$_}))."\t$_\n";
	}
}

sub sort_by_size{
        my (%files)=%{$_[0]};
        for (sort { $files{$a} <=> $files{$b} } keys %files){
                print $files{$_}."\t$_\n";
        }
}

if ($#ARGV<1){
        print "Usage: ./vdir.pl <time|size> <dir path>\n";
	exit;
}

my $mode=$ARGV[0];
my $dir=$ARGV[1];

find(\&check_files,($dir));

switch ($mode){
	case "time"	{&sort_by_modify_time(\%files_by_modify_time);}
	case "size"	{&sort_by_size(\%files_by_size);}
}

