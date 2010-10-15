#!/usr/local/bin/perl -I./

use strict;
use warnings;
use Text::CSV;

my @output_array;

my $csv=Text::CSV->new({ binary => 1 });
open my $file,"file.csv";
$csv->column_names("1","2","3");
while (my $built_hash=$csv->getline_hr($file)){
	push (@output_array,{%$built_hash});
}
close $file;

for my $crt_hash (@output_array){
	print "Hash here:\n";
	for (keys %$crt_hash){
		print "$_ -> $crt_hash->{$_}\n";
	}
}

###########################

open my $file,">","file1.csv";

for my $crt_hash (@output_array){
	print "Hash here:\n";
	my @cols;

	push (@cols,$crt_hash->{"1"});
	push (@cols,$crt_hash->{"2"});
	push (@cols,$crt_hash->{"3"});

	$csv->combine(@cols);
 	my $line=$csv->string();
	print "Linie: $line\n";
	print $file "$line\n";
}
close $file;

