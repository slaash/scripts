#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket::INET;
use Switch;

sub process{
	my $client_sock=$_[0];
	my $client_cmd=$_[1];
	chomp $client_cmd;
	switch ($client_cmd){
		case /by/ { &conn_close($client_sock); }
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
			print "closed connection $r_conn_host:$r_conn_port -> $l_conn_host:$l_conn_port\n"; 
		}
		else{
			print "eroare la close ?!\n";
		}
	}
	else{
		print "not connected !\n";
	}
	exit;
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

my $rcv;
my $new_sock;
my $pid;
my $sock = IO::Socket::INET->new(Listen    => 1,
                                 LocalAddr => '163.242.224.14',
                                 LocalPort => 65001,
				 TimeOut   => 5,
				 Reuse     => 1,
                                 Proto     => 'tcp',
				 Type	   => SOCK_STREAM) || die "Error: create socket failed !";
while ($new_sock=$sock->accept()){
	print "received connection from ".$new_sock->peerhost().":".$new_sock->peerport()."\n";
	$new_sock->autoflush(1);
	print "will fork...\n";
	$pid=fork();
	if ($pid==0){
		$sock->close();
		while ($rcv=<$new_sock>){
			&server_log($new_sock,$rcv);
			&process($new_sock,$rcv);
		}
		&conn_close($new_sock);
		print "will exit...\n";
		exit;
	}
#	&conn_close($new_sock);
}

