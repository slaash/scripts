#!/usr/bin/perl

use Socket;
open FILE,$ARGV[0];
while ($LINIE=<FILE>){
	if ($LINIE=~/Unrecognized attempt blocked from/){
		chomp($LINIE);
		@L=split(/ /,$LINIE);
		@SRC=split(/:/,$L[9]);
		@DST=split(/:/,$L[12]);
		$shost=gethostbyaddr(inet_aton($SRC[0]),AF_INET);
		$shost="";
		if (length($shost)==0){
			$shost=$SRC[0];
		}
		$psp="\t".$DST[1]."/".lc($DST[0])."\t";
		@LN="";
		open SERV,"/etc/services";
		while ($LIN=<SERV>){
			if ($LIN=~/$psp/){
				@LN=split(/(\s)+/,$LIN);
			}
		}
		close SERV;
		print $L[0]." ".$L[1]." ".$L[2]." ".$L[3]."    From: ".$shost."    Port: ".$DST[1]."/".$DST[0]."    ".$LN[0]."\n";

	}
}
close FILE;

