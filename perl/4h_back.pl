#!/usr/bin/perl

#19.02.2007 Radu Moisa
#the script has two arguments, the date (e.g. 2007/01/31) and time (e.g. 14:30:59)
#it displays the give date/time minus 4 hours

sub two_digits{
#if the parameter is just one character long (e.g. 1 instead of 01), it prefixes it with 0
	if (length($_[0])<2){
		return "0".$_[0];
	}
	else{
		return $_[0];
	}
}

if ($#ARGV<1){
	exit 1;
}

$date=$ARGV[0];
$time=$ARGV[1];
@y_m_d=split(/\//,$date);
@h_m_s=split(/:/,$time);

$year=$y_m_d[0];
$month=$y_m_d[1];
$day=$y_m_d[2];

$hour=$h_m_s[0];
$min=$h_m_s[1];
$sec=$h_m_s[2];

%last_day=("1"=>"31","2"=>"28","3"=>"31","4"=>"30","5"=>"31","6"=>"30","7"=>"31","8"=>"31","9"=>"30","10"=>"31","11"=>"30","12"=>"31");

if ($hour>=4){
	$hour=$hour-4;
}
else{
	$hour=24-(4-$hour);
	if ($day>1){
		$day--;
	}
	else{
		if ($month>1){
			$month--;
		}
		else{
			$month=12;
			$year--;
		}
		$day=$last_day{$month};
	}
}

print "$year\/".two_digits($month)."\/".two_digits($day)." ".two_digits($hour).":$min:$sec\n";

