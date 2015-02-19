#!/usr/bin/perl

use Term::ANSIColor;
use DBI();
use Socket;

my $dbh=DBI->connect("DBI:mysql:database=ulogd;host=localhost","ulogduser","logging");
my $sth= $dbh->prepare("select ip_saddr,ip_daddr,oob_time_sec,oob_in,ip_protocol,tcp_sport,tcp_dport,udp_sport,udp_dport,icmp_type,tcp_syn,tcp_fin,tcp_ack,tcp_psh,ip_ttl from ulog where oob_prefix='".$ARGV[0]."' order by oob_time_sec desc");
$sth->execute();
$old_src="0.0.0.0";
$scan_in_progress=0;
$counter=1;
while (my $ref=$sth->fetchrow_hashref()){
  $d= $ref->{'ip_saddr'}%256;
  $c=($ref->{'ip_saddr'} / 256)%256;
  $b=($ref->{'ip_saddr'} / 256 / 256)%256;
  $a=($ref->{'ip_saddr'} / 256 / 256 / 256)%256;
  $t= $ref->{'ip_daddr'}%256;
  $z=($ref->{'ip_daddr'} / 256)%256;
  $y=($ref->{'ip_daddr'} / 256 / 256)%256;
  $x=($ref->{'ip_daddr'} / 256 / 256 / 256)%256;
  $time=localtime($ref->{'oob_time_sec'});
  @t=split(/\s+/,$time);
  if ($t[2]%2==0){
  $color='green';
  }
  else {
  $color='red';
  }
  print color $color;
  print $time," ";
  print $ref->{'oob_in'}," ";
  print color 'white';
  $src=$a.".".$b.".".$c.".".$d;
if ($ARGV[1] eq "N"){
  $hsrc=gethostbyaddr(inet_aton($src),AF_INET);
}
  if ($hsrc eq ""){
      print $src," ";
  }
  else{
      print $hsrc," ";
  }
  print color $color;
  $dst=$x.".".$y.".".$z.".".$t;
  print color 'yellow';
  open (CMD,"geoiplookup ".$src."|cut -d ',' -f 2|");
  while ($LN=<CMD>){
    chomp $LN;
    if ($LN ne "GeoIP Country Edition: IP Address not found"){
        print $LN." ";
    }
  }
  close CMD;
  print color $color;
if ($ARGV[1] eq "N"){
  $hdst=gethostbyaddr(inet_aton($dst),AF_INET);
}
  if ($hdst eq ""){
      print $dst," ";
  }
  else{
      print $hdst," ";
  }
  if ($ref->{'ip_protocol'}==1){
    print "ICMP ";}
  if ($ref->{'ip_protocol'}==6){
    print "TCP ";}
  if ($ref->{'ip_protocol'}==17){
    print "UDP ";}
  print $ref->{'tcp_sport'}," ";
  print $ref->{'tcp_dport'}," ";
  print $ref->{'udp_sport'}," ";
  print $ref->{'udp_dport'}," ";
  print $ref->{'icmp_type'}," ";;
  if ($ref->{'tcp_syn'}){
    print "S ";}
  if ($ref->{'tcp_fin'}){
    print "F ";}
  if ($ref->{'tcp_ack'}){
    print "A ";}
  if ($ref->{'tcp_psh'}){
    print "P ";}
  print "TTL: ".$ref->{'ip_ttl'};
  print "\n";   
  print color 'reset';
  
  if ($src eq $old_src){
    $counter++;
    if ($counter>=5){
	$scan_in_progress=1;
    }
  }
  else{
    if ($scan_in_progress==0){
        $counter=1;
    }
    else{
	$scan_in_progress=0;
	print "Scanned ".$counter." ports from ".$src." started on ".$time."\n";
	$counter=1;
    }
  }
  $old_src=$src;

 
}

if ($scan_in_progress==1){
    print "Scanned ".$counter."ports from ".$src." started on ".$time."\n";
}

$sth->finish();
$dbh->disconnect();
