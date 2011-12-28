use strict;
use warnings;

use Data::Dumper;
use Scalar::Util 'reftype';

use Android;

sub showrez{
	my $rez=$_[0];
	my $reftype = reftype $rez->{result};
	if (!defined $reftype){
		print "$rez->{result}\n";
	}
	elsif($reftype eq 'HASH'){
		for (keys $rez->{result}){
			print "$_ => $rez->{result}->{$_}\n";
		}
	}
	elsif($reftype eq 'ARRAY'){
		for (@{$rez->{result}}){
			print "$_\n";
		}
	}
	else{
		print "showrez: data type is $reftype\n";
	}
}

my $a=Android->new();
$a->makeToast("Mumu from perl!");

my $rez=$a->getLaunchableApplications();
&showrez($rez);

$rez=$a->getRunningPackages();
&showrez($rez);

#$a->launch("com.android.contacts.DialtactsActivity");
#$a->phoneCallNumber("0745815430");

$rez=$a->dialogGetInput("Input dialog","User input here");
&showrez($rez);
#$a->dialogShow();




