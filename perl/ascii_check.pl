#!/usr/local/bin/perl

BEGIN { unshift @INC, '/HOME/infouser/scripts/vwimex/release/modules'; }


use strict;
use warnings;
use Text::CSV;
use IO::File;


my $usage = qq(
usage: ascii_check input_file output_file
input_file is mandatory
if output_file is omitted then the new ascii file with bad ascii characters removed will be by default ascii_output_checked.csv
the script also creates ascii_output.csv which list the PR's with bad ascii characters and the associated fields
);

my $output_checked_file;


if (!@ARGV) {
        die $usage;
	}


die $usage unless ($ARGV[0]);


if ($ARGV[1]) {
	$output_checked_file = $ARGV[1];
	}
else {
	$output_checked_file = "ascii_output_checked.csv";
	}
	


unlink "ascii_output.csv" if -e "ascii_output.csv";
unlink "ascii_output_checked.csv" if -e "ascii_checked_output.csv"; 
unlink "ascii_output_checked_tr.csv" if -e "ascii_output_checked_tr.csv";



my $csv = Text::CSV -> new({binary=>'1', sep_char=>';', verbatim => '1', eol=>$/});
my $input_file = $ARGV[0];
my $pr_file = new IO::File "< $input_file" or die "Could not open PR file: $!\n";
my $output_file = new IO::File "> ascii_output.csv"; 

system "/usr/bin/dos2unix -ascii $input_file $input_file";


my @fields;
while (my  $head = $csv -> getline($pr_file)) {
        my $i;
        for ($i = 0; $i<= 50; $i++) {
        push @fields, $$head[$i];
        }
      last;
								        }




my @current_field;
my $current_char;
my $row;
my @output_file_format = qw (PR_Number Field_1 Field_2 Field_3 Field_4 Field_5);
$csv -> print ($output_file, \@output_file_format) or die  "Can't open output file: $!\n";
	while ($row = $csv -> getline($pr_file)) {
			if ($$row[1] && $$row[1] =~ /\d+/) {
			my @bad_fields;
			my $current_pr = $$row[1];
			print "Checking PR $current_pr ...\n";
			push @bad_fields, $current_pr;
			my $i;
			for ($i = 0; $i <= 50; $i++) {
				#print ".................Checking field $i ..............\n";
				@current_field = split (//, $$row[$i]);
					while ($#current_field >= 0) {
						$current_char = shift @current_field;
						my $asc = ord ($current_char);
						#print "$asc  <----------\n" if ($i == 50 && $#current_field == 0);
						if (ord ($current_char) < 32 && ord($current_char) != 10 && ord($current_char) != 13 ) {
							push @bad_fields, $fields[$i] unless ($bad_fields[-1] eq $fields[$i]);
							last;
							}
						}
					#print "--------------!!!!!!!!!!!!!!!!------------- Campul checkuit este $current_checked_field ------------!!!!!!!!!!!!_________________\n";
					
				#print "@@@@@@@@@@@@@@!!!!!!!!!!!!!____ Array-ul checked_fields are $#checked_fields indexi _____ !!!!!!!@@@@@@@@@@@@@\n";

				}
				
			#print "...................................Dimensiunea lui bad_fields este $#bad_fields\n";	
			$csv -> print ($output_file, \@bad_fields)  if ($#bad_fields > 0);
			}
		}


system "/usr/local/bin/tr -cd \'\\12\\15\\40-\\376\' < $input_file > $output_checked_file";


