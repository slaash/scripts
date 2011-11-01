use strict;
use warnings;
use Date::Calc qw(Localtime Delta_YMDHMS);

#use Data::Dumper;

use Text::CSV;
use Getopt::Long;

sub get_my_prj_name{
	my $co_from=$_[0];#the project from which we check out
	my $local_to=`ccm attr -s local_to $co_from`;
	chomp $local_to;
	my $prj_name;
	my $dcm_id=&get_dcm_id();
	if ($local_to eq $dcm_id){
		if ($co_from=~/(.+)-(.+)/){
			$prj_name=$1."-bench_test_$ENV{COMPUTERNAME}";
		}
		else{
			print "1: My project name can not be identified!!! Exiting...\n";
			&ccm_stop;
			exit;
		}
	}
	else{
		if ($co_from=~/(.+)-(.+)(:project:.+)/){
			$prj_name=$1."-".$dcm_id."#bench_test_$ENV{COMPUTERNAME}".$3;
		}
		else{
			print "2: My project name can not be identified!!! Exiting...\n";
			&ccm_stop;
			exit;
		}
	}
	return $prj_name;
}

sub get_dcm_id{
	my $dcm_id=`ccm dcm -dbid -show`;
	chomp $dcm_id;
	return $dcm_id;
}

sub ccm_start{
	my ($db,$srv)=@_;
	print "ccm start\n";
	$ENV{CCM_ADDR}=`ccm start -m -q -d $db -s $srv`;
	print "CCM_ADDR: $ENV{CCM_ADDR}\n";
}

sub ccm_set_role{
	print "ccm set role\n";
	print `ccm set role developer 2>&1`;
}

sub ccm_status{
	print "ccm status\n";
	print `ccm status 2>&1`;
}

sub ccm_copy_project{
	my ($prj,$wa_path,$rel,$purp)=@_;
	print "ccm copy_project\n";
	print `ccm copy_project $prj -subprojects -no_update -release $rel -setpath $wa_path -purpose "$purp" -to bench_test_$ENV{COMPUTERNAME} 2>&1`;
#	print `ccm copy_project $prj -subprojects -to bench_test_$ENV{COMPUTERNAME} 2>&1`;
}

sub ccm_reconcile{
	my $prj=$_[0];
	print "ccm reconcile\n";
	print `ccm reconcile -recurse -project -show $prj 2>&1`;
}

sub ccm_update_members{
	my $prj=$_[0];
	print "ccm update members\n";
	print `ccm update_members -project -keep_subprojects -recurse $prj 2>&1`;
}

sub ccm_delete{
	my $prj=$_[0];
	print "ccm delete\n";
	print `ccm delete -project -scope project_and_subproject_hierarchy $prj 2>&1`;
}

sub ccm_stop{
	print "ccm stop\n";
	print `ccm stop 2>&1`;
}

sub main{
my %opt;
my $usage="usage: \\\\iasp351x\\didl9505\\SCC\\Perl\\v5.8.8.819\\bin\\perl.exe syn_perf_test2.pl -db /appl/ccm/db/Fiat_Ias -srv http://iasp052x.ia.ro.conti.de:8410 -prj Fiat_VP2-01.04.01.00:project:Fiat_WZ#1 -ccm_home \\\\iasp351x\\didl9505\\SCC\\cm_syn\\V7.1L.iasp052x -to_file \\\\storage.ia.ro.conti.de\\IIC-ForAll\\syn_perf_tests\\master.csv -rel VP2/1.4.0 -wa_path D:\\PerfTests -purp \"VP2_TOP Insulated Development\"";
GetOptions(
        "db=s" => \$opt{db},
        "srv=s" => \$opt{srv},
        "prj=s"   => \$opt{prj},
		"ccm_home=s" => \$opt{ccm_home},
		"to_file=s" => \$opt{to_file},
		"wa_path=s" => \$opt{wa_path},
		"rel=s" => \$opt{rel},
		"purp=s" => \$opt{purp}
		  ) or die "$usage";
		  
#print Dumper %opt;

if (!defined $opt{db} or !defined $opt{srv} or !defined $opt{prj} or !defined $opt{ccm_home} or !defined $opt{to_file} or !defined $opt{wa_path} or !defined $opt{rel} or !defined $opt{purp}){
	die $usage;
}

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
&ccm_set_role();
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm set role developer
$line[6]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_status();
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm status
$line[7]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_copy_project($opt{prj},$opt{wa_path},$opt{rel},$opt{purp});
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm copy_project
$line[8]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

my $prj_name=&get_my_prj_name("$opt{prj}");
print "My project: $prj_name\n";

@st_tm=Localtime();
&ccm_reconcile($prj_name);
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm reconcile
$line[9]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_update_members($prj_name);
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm upd members
$line[10]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_reconcile($prj_name);
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm reconcile
$line[11]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_delete($prj_name);
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm del
$line[12]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

@st_tm=Localtime();
&ccm_stop();
@en_tm=Localtime();
($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS($st_tm[0],$st_tm[1],$st_tm[2],$st_tm[3],$st_tm[4],$st_tm[5],$en_tm[0],$en_tm[1],$en_tm[2],$en_tm[3],$en_tm[4],$en_tm[5]);
#duration on ccm del
$line[13]="$D_y/$D_m/$D_d $Dh:$Dm:$Ds";

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
