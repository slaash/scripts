#!/usr/bin/perl

use strict;
use warnings;
use File::Spec;

sub find_item{
	my $dir=File::Spec->canonpath($_[0]);
	my $DIR;
	print("$dir\n");
	eval{
		opendir($DIR,$dir);
	};
	if ($@){
		print "$@\n";
	}
	else{
		while (my $item=readdir($DIR)){
			if ($item ne "." and $item ne ".."){
				my $fullitem=File::Spec->join($dir,$item);
				if (-d $fullitem){
					find_item($fullitem);
				}
				else{
					print "$fullitem\n";
				}
			}
		}
		closedir($DIR);
	}
}

my $s_dir=$ARGV[0];
find_item($s_dir);

