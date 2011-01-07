#!/usr/bin/perl

use strict;
use warnings;

use File::stat;
use File::Find;
use POSIX qw(strftime);

use Data::Dumper;

my %files;

sub display{
	my $file=$_;
	my $dir=$File::Find::dir;
	chdir $dir;
	if (-f $_){
		$files{"$dir/$file"}=(stat($_))->[9];
	}
}

my $dir;
if ($ARGV[0]){
        $dir=$ARGV[0];
}
else{
        print "No file given!\n";
        exit;
}

find(\&display,($dir));

for (sort { $files{$a} <=> $files{$b} } keys %files){
	print strftime("%Y/%m/%d %H:%M:%S",localtime($files{$_}))."\t$_\n";
}
