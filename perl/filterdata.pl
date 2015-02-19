#!/usr/local/bin/perl
BEGIN { unshift @INC, '/HOME/infouser/scripts/vwimex/release/modules'; }
use strict;
use warnings;

use IO::File;
use POSIX 'strftime';
use Text::CSV;
sub add_quotes{
        my $field=shift;
        if ($field ne ""){
                $field=~s/"/""/g;
                $field="\"$field\"";
        }
        return $field;
}
my $csv_file=shift;

my $row;
my @excluded;
my $csv=Text::CSV->new({binary => 1, eol => $/, sep_char=>';'});
my $new_csv = Text::CSV->new({binary => 1, sep_char=>';', eol=> $/,quote_char=> undef});
my $file_in;
my $file_out;
my $filter;
my $logfile;
system "dos2unix -ascii $csv_file $csv_file";
open $logfile,">>","filterData.log";
print "Started Filter Data RNS on ".localtime()."\n";
print $logfile "Started Filter Data RNS on ".localtime()."\n";

open $filter,"<","Excluded_PRs.lst";
while(<$filter>){
	chomp($_);
	push(@excluded,$_);	
}
close($filter);
open $file_in,$csv_file;
my $new_csv_file=$csv_file;
$new_csv_file=~s/\.csv/_Filter\.csv/g;
open $file_out,">",$new_csv_file;
while($row=$csv->getline($file_in)){
	my $size=@$row;
	if($size==51){
		if ($row->[0] ne "Aktion"){
			$row->[7]=&add_quotes("$row->[7]");
			$row->[8]=&add_quotes("$row->[8]");
			$row->[9]=&add_quotes("$row->[9]");
			$row->[43]=&add_quotes("$row->[43]");
			$row->[44]=&add_quotes("$row->[44]");
			$row->[49]=&add_quotes("$row->[49]");
			if ($row->[50] =~ /\s/){
				$row->[50]="\"".$row->[50]."\"";
			}
		}
		if(grep $_ eq $row->[1],@excluded){
			print "$row->[1] is an excluded PR\n";
				
		}
		else{
			$new_csv->print($file_out,$row);
		}
	}
}
close($file_in);
close($file_out);
close($logfile);
print "Finished filtering import file\n";
