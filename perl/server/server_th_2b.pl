#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket::INET;
use Switch;
use threads;
use threads::shared;

my $ip="163.242.224.14";
my $port=65001;

my $close_req=0;
my $sock;
my $new_sock;
my $t;
my $t_nr : shared = 0;
my %guests : shared;
my %guests_hist : shared;

sub add_guest{
	my $ip=$_[0];
	my $port=$_[1];
	lock %guests;
	$guests{$ip}=$port;
}

sub del_guest{
	my $ip=$_[0];
	lock %guests;
	delete $guests{$ip};
}

sub add_guest_hist{
	my $ip=$_[0];
	my $cmd=$_[1];
	lock %guests_hist;
	$guests_hist{$ip}=$cmd;
}

sub dump_guests{
	my $ip;
	my $client_sock=$_[0];
	foreach $ip (keys %guests){
		print "$ip:$guests{$ip}\n";
		&server_reply($client_sock,"$ip:$guests{$ip}\n");
	}
}

sub dump_hist{
	my $hostip;
	my $client_sock=$_[0];
	foreach $hostip (keys %guests_hist){
		print "$hostip: $guests_hist{$hostip}\n";
		&server_reply($client_sock,"$hostip: $guests_hist{$hostip}\n");
	}
}

sub process{
	my $client_sock=$_[0];
	my $client_cmd=$_[1];
	chomp $client_cmd;
	switch ($client_cmd){
		case /^by/ { $close_req=1; }
		case /^threads/ {&server_reply($client_sock,"$t_nr threads");}
		case /^guests/ {&dump_guests($client_sock);}
		case /^hist/ {&dump_hist($client_sock);}
		else 	  { &server_reply($client_sock,"OK"); }
	}
}		

sub conn_close{
	my $conn=$_[0];
        my $l_conn_host=$conn->sockhost();
        my $l_conn_port=$conn->sockport();
	my $r_conn_host=$conn->peerhost();
	my $r_conn_port=$conn->peerport();
	if ($conn->connected()){
		&server_reply($conn,"Good Bye !");
		if ($conn->close()){
			print "\tclosed connection $r_conn_host:$r_conn_port -> $l_conn_host:$l_conn_port\n";
		}
		else{
			print "\teroare la close ?!\n";
		}
	}
	else{
		print "\tnot connected !\n";
	}
}

sub server_reply{
	my $conn=$_[0];
        my $msg=$_[1];
	print $conn "SERVER: $msg\n\r";
}

sub server_log{
	my $conn=$_[0];
	my $msg=$_[1];
	my $rmt_host=$conn->peerhost();
	my $rmt_port=$conn->peerport();
	my $pkt_size;
	{
	use bytes;
	$pkt_size=length($msg);
	}
	chomp $msg;
	print "$pkt_size bytes: ($rmt_host:$rmt_port): $msg\n";
}

sub new_conn{
	my $client_sock=$_[0];
	my $rcv;
	{
	lock($t_nr);
	$t_nr++;
	}
	print "started thread ".threads->self->tid().", $t_nr threads existing\n";
	&add_guest($client_sock->peerhost(),$client_sock->peerport());
	while ($client_sock->connected() and $rcv=<$client_sock> and $close_req==0){
		&server_log($client_sock,$rcv);
		&add_guest_hist($client_sock->peerhost().":".$client_sock->peerport(),$rcv);
		&process($client_sock,$rcv);
	}
	&conn_close($client_sock);
	print "exit thread ".threads->self->tid()."\n";
        {
        lock($t_nr);
        $t_nr--;
        }
}

if ($sock = IO::Socket::INET->new(Listen    => 1,
                                 LocalAddr => $ip,
                                 LocalPort => $port,
				 TimeOut   => 5,
				 Reuse     => 1,
                                 Proto     => 'tcp',
				 Type	   => SOCK_STREAM)){
	print "listening on $ip:$port\n";
}
else{
	die "Error: create socket failed !";
}

binmode $sock;
while ($new_sock=$sock->accept()){
	print "received connection from ".$new_sock->peerhost().":".$new_sock->peerport()."\n";
	$new_sock->autoflush(1);
	binmode $new_sock;
	$t = threads->new(\&new_conn,$new_sock);
	$t->detach();
}

