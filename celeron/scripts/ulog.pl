#!/usr/bin/perl

use Term::ANSIColor;
use DBI();
use Socket;

if (length($ARGV[0])==0){
print "usage:\n";
print "./ulog.pl [SSH_RECENT_DROP|TCP_DROP|UDP_DROP|ICMP_DROP|I_INVALID|F_INVALID] [names] [dest] [geo]\n\n";
}
else{

$names=0;
$dest=0;
$geo=0;
foreach $i(@ARGV){
    if ($i eq "names"){
	$names=1;
    }
    if ($i eq "dest"){
	$dest=1;
    }
    if ($i eq "geo"){
	$geo=1;
    }
}

open (FILE,"/etc/services");

$dbh=DBI->connect("DBI:mysql:ulogd;host=localhost","ulogduser","logging");
$sth=$dbh->prepare("select ip_saddr,ip_daddr,oob_time_sec,oob_in,ip_protocol,tcp_sport,tcp_dport,udp_sport,udp_dport,icmp_type,tcp_syn,tcp_fin,tcp_ack,tcp_psh,ip_ttl from ulog where oob_prefix='".$ARGV[0]."' order by oob_time_sec desc");
$sth->execute();
while ($ref=$sth->fetchrow_hashref()){
  $d= $ref->{'ip_saddr'}%256;
  $c=($ref->{'ip_saddr'} / 256)%256;
  $b=($ref->{'ip_saddr'} / 65536)%256;
  $a=($ref->{'ip_saddr'} / 16777216)%256;
  
  $t= $ref->{'ip_daddr'}%256;
  $z=($ref->{'ip_daddr'} / 256)%256;
  $y=($ref->{'ip_daddr'} / 65536)%256;
  $x=($ref->{'ip_daddr'} / 16777216)%256;
  
  $time=localtime($ref->{'oob_time_sec'});
  @t=split(/\s+/,$time);
  if ($t[2]%2==0){
  $color='green';
  }
  else {
  $color='red';
  }
  print color $color;
  print $time." ";
  if ($ref->{'oob_in'} eq "eth0"){
    print "EXT ";
  }
  else{
    print "INT ";
  }
  print color 'white';
  $src=$a.".".$b.".".$c.".".$d;
if ($names==1){
  $hsrc=gethostbyaddr(inet_aton($src),AF_INET);
}
  if (length($hsrc)==0 or ($hsrc eq ".")){
      print $src;
  }
  else{
      print $hsrc;
  }
  print color $color;
  $dst=$x.".".$y.".".$z.".".$t;
if ($geo==1){
  open (CMD,"geoiplookup ".$src."|cut -d ',' -f 2|");
  while ($LN=<CMD>){
    chomp $LN;
    if ($LN ne "GeoIP Country Edition: IP Address not found"){
        print $LN;
    }
  }
  close CMD;
}
print " ";
if ($dest==1){
    print color 'white';
    if ($names==1){
	$hdst=gethostbyaddr(inet_aton($dst),AF_INET);
    }
    if (length($hdst)==0 or ($hdst eq ".")){
	print $dst." ";
    }
    else{
	print $hdst." ";
    }
}
print color 'yellow';
  if ($ref->{'ip_protocol'}==1){
    print "ICMP ".$ref->{'icmp_type'}." ";
  }
  if ($ref->{'ip_protocol'}==6){
    print "TCP ".$ref->{'tcp_sport'}."->".$ref->{'tcp_dport'}." ";
    if ($ref->{'tcp_syn'}){
	print "S ";}
    if ($ref->{'tcp_fin'}){
	print "F ";}
    if ($ref->{'tcp_ack'}){
	print "A ";}
    if ($ref->{'tcp_psh'}){
	print "P ";}												  
    seek (FILE,0,0);
    while ($LINIE=<FILE>){
	chomp $LINIE;
        if ($LINIE !~ /^\#/){
	    @L=split(/\s+/,$LINIE);
	    @M=split(/\//,$L[1]);
	    if (($M[1] eq "tcp") and ($M[0] == $ref->{'tcp_dport'})){
		print "(".uc($L[0]).") ";
	    }
        }
    }
  }
  if ($ref->{'ip_protocol'}==17){
    print "UDP ".$ref->{'udp_sport'}."->".$ref->{'udp_dport'}." ";
    seek (FILE,0,0);
    while ($LINIE=<FILE>){
	chomp $LINIE;
	if ($LINIE !~ /^\#/){
		@L=split(/\s+/,$LINIE);
		@M=split(/\//,$L[1]);
		if (($M[1] eq "udp") and ($M[0] == $ref->{'udp_dport'})){
		    print "(".uc($L[0]).") ";
	    	}
        }
    }
  }
  print color $color;
  print "TTL:".$ref->{'ip_ttl'};
  print "\n";   
  print color 'reset';
}

close FILE;
$sth->finish();
$dbh->disconnect();
}
