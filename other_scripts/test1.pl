#!o:\bin\perl.exe

use strict;
use warnings;
use Tk;
use Win32::Clipboard;

my $CLIP = Win32::Clipboard();

my $window = new MainWindow;

my $menubar=$window->Menu();

$window->configure(-title=>'Main application',-background=>'grey',-menu=>$menubar);
#$window->geometry("800x600");
$window->resizable(0,0);

my $menufile=$menubar->cascade(-label=>"File",-tearoff=>0);
my $menuedit=$menubar->cascade(-label=>"Edit",-tearoff=>0);
my $menuhelp=$menubar->cascade(-label=>"Help",-tearoff=>0);

$menufile->command(-label=>"New", -command=>\&new_file);
$menufile->command(-label=>"Open", -command=>\&open_file);
$menufile->command(-label=>"Save", -command=>\&save_file);
$menufile->command(-label=>"Run", -command=>\&run_cmd);
$menufile->separator();
$menufile->command(-label=>"Exit", -command=>\&exit_app);

$menuedit->command(-label=>"Copy",-command=>\&copy_text);
$menuedit->command(-label=>"Paste",-command=>\&paste_text);

$menuhelp->command(-label=>"About", -command=>\&about);

my $cmdframe=$window->Frame();
my $cmdlabel=$cmdframe->Label(-text=>"Cmd:");
my $cmdline=$cmdframe->Entry(-width=>'89');
my $cmdbutton=$cmdframe->Button(-text=>" Run ",-command=>\&run_cmd);
my $resultframe=$window->Frame();
my $resultlabel=$resultframe->Label(-text=>"Result");
my $textarea=$resultframe->Text(-width=>83,-height=>20,-wrap=>'char');
my $srl_y = $resultframe -> Scrollbar(-orient=>'v',-command=>[yview => $textarea]);
my $srl_x = $resultframe -> Scrollbar(-orient=>'h',-command=>[xview => $textarea]);
$textarea->configure(-yscrollcommand=>['set', $srl_y],-xscrollcommand=>['set',$srl_x]);

$cmdlabel->grid(-row=>1,-column=>1);
$cmdline->grid(-row=>1,-column=>2);
$cmdbutton->grid(-row=>1,-column=>3);
$cmdframe->grid(-row=>1,-column=>1,-columnspan=>3);
$resultlabel->grid(-row=>2,-column=>1);
$textarea->grid(-row=>3,-column=>1);
$srl_y->grid(-row=>3,-column=>2,-sticky=>"ns");
$srl_x->grid(-row=>4,-column=>1,-sticky=>"ew");
$resultframe->grid(-row=>2,-column=>1,-columnspan=>3);

sub new_file{
$textarea->delete('1.0','end');
}

sub open_file{
my $file=$window->getOpenFile();
open FILE,"$file";
while (<FILE>){
	$textarea->insert('end',$_);
}
close FILE;
}

sub save_file{
my $file=$window->getSaveFile();
open FILE,">",$file;
print FILE $textarea->get('1.0','end');
close FILE;
}

sub paste_text{
$textarea->insert('end',$CLIP->Get());
}

sub exit_app{
my $response=$window->messageBox(-type=>"yesno",-message=>"Want to quit ?",-icon=>"question");
if ($response eq "Yes"){
	exit;
}
}

sub about{
$window->messageBox(-type=>"ok",-message=>"By Radu !",-icon=>"info");
}

sub run_cmd{
my $cmd=$cmdline->get();
$textarea->delete('1.0','end');
open CMD,"$cmd|";
while (<CMD>){
	$textarea->insert('end',$_);
}
close CMD;
}

MainLoop();
