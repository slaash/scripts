#!/usr/local/bin/perl

use strict;
use warnings;
use File::Find;
use File::Path;

if ( scalar @ARGV < 3 ) {
	print "Usage: $0 <target directory> <no. of days> <pattern1> ... <patternN>\n";
	exit 0;
}

my $target_directory = $ARGV[0];
my $days = $ARGV[1];

if ( ! -d $target_directory ) {
	print "$target_directory is not a directory.\n";
	exit 0;
}

if ( $days !~ /\d+/ ) {
	print "Numeric argument required, $days provided.\n";
	exit 0;
}

my ($regex,$i);
for ($i = 2; $i <= $#ARGV; $i++){
	if ($ARGV[$i] !~ /^[A-Za-z_\s]+$/) {
		print "Usage: Illegal char in pattern $ARGV[$i].\n";
		exit 0;
	}
	$regex .= "\/^$ARGV[$i].*\/";
	$regex .= " || " unless $i >= $#ARGV;
}

File::Find::find({wanted => \&wanted}, $target_directory);
sub wanted {
	if (eval($regex) and int(-M $_)>$days){
		$File::Find::prune=1;
		if (-f || -d){
			print "Removing: $File::Find::name\n";
			if (-f) {
				system("rm $File::Find::name");
			}
			elsif (-d) {
				system("rm -rf $File::Find::name");
			}
		}
	}
}
exit;

