#!/usr/bin/perl
#it just increments the last part of the addr, port number is first parameter

my $prefix;
my $port=$ARGV[0];
my @chars=(0..9,a..f);
my @word;
my $crt_addr=`/sbin/ifconfig tun|grep Scope:Global|tr -s ' '|cut -d ' ' -f 4|cut -d '/' -f 1`;
chomp $crt_addr;
if ($crt_addr=~/(.+:).+$/){
	$prefix=$1;
}
print "prefix= $prefix\n";
foreach (@chars){
	$word[0]=$_;
	foreach (@chars){
		$word[1]=$_;
		foreach (@chars){
			$word[2]=$_;
			foreach (@chars){
				$word[3]=$_;
				$result=join('',@word);
				if ($result=~/^0+$/){
#					$result="0";
				}
				else{
#					$result=~s/^0+//g;
				}
				my $cmd="nmap -6 -oG - -p $port $prefix$result|grep \"\/open\/\"";
				print "$cmd\n";
				system "$cmd";	
			}
		}
	}
}

