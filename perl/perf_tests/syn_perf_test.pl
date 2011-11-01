use strict;
use warnings;
use Date::Calc qw(Localtime Delta_YMDHMS);

#use Data::Dumper;

use Text::CSV;
use Getopt::Long;

sub ccm_start{
	my ($db,$srv)=@_;
	print "ccm start\n";
	$ENV{CCM_ADDR}=`ccm start -m -q -d $db -s $srv`;
	print "CCM_ADDR: $ENV{CCM_ADDR}\n";
}

sub ccm_status{
	print "ccm status\n";
	print `ccm status 2>&1`;
}

sub ccm_copy_project{
	my ($prj,$wa_path)=@_;
	print "ccm copy_project\n";
	print `ccm copy_project $prj -subprojects -no_update -setpath $wa_path -to bench_test_$ENV{COMPUTERNAME} 2>&1`;
#	print `ccm copy_project $prj -subprojects -to bench_test_$ENV{COMPUTERNAME} 2>&1`;
}

sub ccm_reconcile{
	my $prj=$_[0];
	print "ccm reconcile\n";
	my $prj_name;
	if ($prj=~/(.+)-(.+)/){
		$prj_name=$1;
	}
	if (!defined $prj_name){
		print "Could not identify working project!\n";
		return -1;
	}
	print "$prj_name\n";
	print `ccm reconcile -recurse -project -show $prj_name-bench_test_$ENV{COMPUTERNAME} 2>&1`;
}

sub ccm_update_members{
	my $prj=$_[0];
	print "ccm update members\n";
	my $prj_name;
	if ($prj=~/(.+)-(.+)/){
		$prj_name=$1;
	}
	if (!defined $prj_name){
		print "Could not identify working project!\n";
		return -1;
	}
	print "$prj_name\n";
	print `ccm update_members -project -keep_subprojects -recurse $prj_name-bench_test_$ENV{COMPUTERNAME} 2>&1`;
}

sub ccm_delete{
	my $prj=$_[0];
	print "ccm delete\n";
	my $prj_name;
	if ($prj=~/(.+)-(.+)/){
		$prj_name=$1;
	}
	if (!defined $prj_name){
		print "Could not identify working project!\n";
		return -1;
	}
	print "$prj_name\n";
	print `ccm delete -project -scope project_and_subproject_hierarchy $prj_name-bench_test_$ENV{COMPUTERNAME} 2>&1`;
	
}

sub ccm_stop{
	print "ccm stop\n";
	print `ccm stop 2>&1`;
}

sub main{
my %opt;
GetOptions(
        "db=s" => \$opt{db},
        "srv=s" => \$opt{srv},
        "prj=s"   => \$opt{prj},
		"ccm_home=s" => \$opt{ccm_home},
		"to_file=s" => \$opt{to_file},
		"wa_path=s" => \$opt{wa_path}
		  ) or die "usage: syn_perf_test.pl -db <db path> -srv <http://...> -prj <project to copy from> -ccm_home <\\\\iasp351x\\didl9505\\SCC\\cm_syn\\V7.1L.wetp051x> -to_file \\\\storage\\IIC-ForAll\\syn_perf_tests\\master.csv -wa_path d:\\smth\\";
		  
#print Dumper %opt;

$ENV{CCM_HOME}=$opt{ccm_home};
$ENV{PATH}=$ENV{CCM_HOME}."\\bin;".$ENV{PATH};
my @st_tm;
my @en_tm;
my @glob_st;
my ($D_y,$D_m,$D_d, $Dh,$Dm,$Ds);
my @line;
my $db_id="";
if ($opt{db} =~ /(.+\/)+(.+)/){
	$db_id=$2;
}

@st_tm=Localtime();
@glob_st=@st_tm;
#first column is start time of first action
push(@line,"$st_tm[0]/$st_tm[1]/$st_tm[2] $st_tm[3]:$st_tm[4]:$st_tm[5]",$ENV{USERNAME},$ENV{COMPUTERNAME},$db_id,"");
&ccm_start($opt{db},$opt{srv});
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm start
$line[5]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_status();
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm status
$line[6]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_copy_project($opt{prj},$opt{wa_path});
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm copy_project
$line[7]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_reconcile($opt{prj});
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm reconcile
$line[8]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_update_members($opt{prj});
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm upd members
$line[9]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_delete($opt{prj});
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm del
$line[10]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_stop();
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm del
$line[11]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

#total duration = glob_st-last en_tm
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($glob_st[0],$glob_st[1],$glob_st[2],$glob_st[3],$glob_st[4],$glob_st[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
$line[4]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

#here we try for one minute (6 times) to write to the csv file...
my $csv=Text::CSV->new({binary => 1, eol => $/, sep_char=>';'});
my $try=0;
my $file;
while($try<6){
        eval{
				open $file,">>","$opt{to_file}" or die "Could not open $opt{to_file}!!!";
        };
        if ($@){
                print "file not available yet...we try again in 10 sec...\n";
                sleep(10);
                $try++;
        }
        else{
                last;
        }
}
if ($try==6){
        print "file could not be open!\n";
}
else{
        print "file open at try #$try\n";
        $csv->print($file,\@line);
		close $file;
}

#print Dumper @line;

}

&main(@ARGV);

