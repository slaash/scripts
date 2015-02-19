#!/usr/local/bin/perl -I/HOME/uidl9555/msext/lib

use strict;
use warnings;
use Text::CSV;

#here we define the file header, names of columns
my @header=("col1","col2","col3");
my $separator=";";

#get_CSV_data(<input csv file>)
#returns an array of hashes
#each hash contains a line of the CSV file
sub get_CSV_data{
my $csvfile=$_[0];
my @output_array;
my $csv=Text::CSV->new({binary=>1, sep_char=>$separator});
my $file;
open $file,$csvfile;
$csv->column_names(@header);
while (my $built_hash=$csv->getline_hr($file)){
        push(@output_array,{%$built_hash});
}
close $file;
return @output_array;
}

#store_CSV_data(<output CSV file>,<array of hashes>)
#stores the content of hashes from array to a CSV file
sub store_CSV_data{
my ($csvfile,@input_data)=@_;
my $csv=Text::CSV->new({binary=>1, sep_char=>$separator});
open my $file,">",$csvfile;
for my $crt_hash (@input_data){
        my @cols;
	for (@header){
		push(@cols,$crt_hash->{"$_"});
	}
        $csv->combine(@cols);
        my $line=$csv->string();
        print $file "$line\n";
}
close $file;
}

my @input=&get_CSV_data("file.csv");
&store_CSV_data("file1.csv",@input);

print "csvfunc ran sucessfully\n";

