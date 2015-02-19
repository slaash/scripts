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

my $rez;

$rez=$a->getLaunchableApplications();
&showrez($rez);

# $rez=$a->getRunningPackages();
# &showrez($rez);

#$a->launch("com.android.contacts.DialtactsActivity");
#$a->phoneCallNumber("0745815430");

# $rez=$a->dialogGetInput("Input dialog","User input here");
# &showrez($rez);
#$a->dialogShow();

# $a->notify("Info","Notice here");

# $a->sendEmail("rmoisa\@yahoo.com","test mail","this is a test");

# $a->setClipboard("from PC");
# $rez=$a->getClipboard();
# &showrez($rez);

# $a->webViewShow("http://www.yahoo.com");

my @layout=("<?xml version=\"1.0\" encoding=\"utf-8\"?>
<LinearLayout xmlns:android=\"http://schemas.android.com/apk/res/android\"
        android:id=\"@+id/background\"
        android:orientation=\"vertical\" android:layout_width=\"match_parent\"
        android:layout_height=\"match_parent\" android:background=\"#ff000000\">
</LinearLayout>");
$a->fullShow(@layout);



