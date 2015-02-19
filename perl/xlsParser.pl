use strict;
use warnings;

use File::stat;
use File::Find;
use POSIX qw(strftime);

use Data::Dumper;

use Spreadsheet::Read;
use Text::CSV;

my %filesByModifyTime;
my $area="";

my $csv=Text::CSV->new({binary => 1, eol => $/, sep_char=>','});
open my $file,">","./out.csv";

sub checkFiles{
        my $file=$_;
        my $dir=$File::Find::dir;
        chdir $dir;
		my @path=split(/\//,$dir);
		if ($path[2]){
			$area=$path[2];
		}
        if (-f $_ and $_=~/(\.xls)|(\.XLS)|(\.xlsx)|(\.XLSX)/){
                $filesByModifyTime{"$dir/$file"}{"time"}=(stat($_))->[9];
				$filesByModifyTime{"$dir/$file"}{"area"}=$area;
        }
}

sub sortByAreaAndModifyTime{
        my (%files)=%{$_[0]};
        for (sort { $files{$a}{"area"} cmp $files{$b}{"area"} || $files{$a}{"time"} <=> $files{$b}{"time"} } keys %files){
			
                print strftime("%Y/%m/%d %H:%M:%S",localtime($files{$_}{"time"}))."\t$_\n";
#				print "$_\n";
				&parseExcel($_);
        }
}

sub parseExcel{
	my $xlsFile=$_[0];
	my $ref = ReadData ($xlsFile);
	$csv->combine($ref->[2]{F7},
				$ref->[2]{B7},		
				$ref->[2]{C29},
				$ref->[2]{B13},
				$ref->[2]{B14},
				$ref->[2]{F3},
				$ref->[2]{D24},
				$ref->[2]{E24},
				$ref->[2]{F24},
				$ref->[2]{B8},
				$ref->[2]{G24},
				$ref->[2]{C35}
				);
	print $file $csv->string();

}

find(\&checkFiles,("./"));

#print Dumper %files_by_modify_time;

&sortByAreaAndModifyTime(\%filesByModifyTime);

close $file;
