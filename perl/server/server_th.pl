#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket::INET;
use IO::Select;
use Switch;
use threads;
use threads::shared;

my $DEBUG=0;

my $ip="163.242.224.14";
my $port=65001;

my $sock;
my $new_sock;
my $t;
my $t_nr : shared = 0;
my $sockets=IO::Select->new();

sub conn_close{
	my $conn=$_[0];
        my $l_conn_host=$conn->sockhost();
        my $l_conn_port=$conn->sockport();
	my $r_conn_host=$conn->peerhost();
	my $r_conn_port=$conn->peerport();
	if ($conn->connected()){
		&server_reply($conn,"Good Bye !");
		$sockets->remove($conn);
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
}

sub server_reply{
	my $conn=$_[0];
        my $msg=$_[1];
	$msg=~s/\n/\r\n/g;
	print $conn "SERVER: $msg\r\n";
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

sub bcast{
	my $msg=$_[0];
	my $i;
	foreach $i ($sockets->handles()){
		&server_reply($i,"broadcast to ".$sockets->count()." clients: ".$msg);
	}
}

sub new_conn{
	my $client_sock=$_[0];
	my $rcv;
	my @cmds;
	my $cmd;
	{
		lock($t_nr);
		$t_nr++;
	}
	if ($DEBUG){print "started thread ".threads->self->tid().", $t_nr threads existing\n";}
	&server_reply($client_sock,"Hello !");
	while ($rcv=<$client_sock>){
        	chomp $rcv;
        	if ($rcv =~ /\r$/){
                	chop $rcv;
        	}
		last if ($rcv=~/by/);
		&server_log($client_sock,$rcv);
        	switch ($rcv){
                	case "threads"	{ &server_reply($client_sock,"$t_nr threads"); }
			case /^cmd:/	{
						@cmds=split(/:/,$rcv);
						if ($#cmds>0){
							$cmd=`$cmds[1] 2>/dev/null`;
							&server_reply($client_sock,"$cmds[1]");
							&server_reply($client_sock,$cmd);
						}
						else{
							&server_reply($client_sock,"ERR");
						}
					}
			case /^bcast:/	{
						@cmds=split(/:/,$rcv);
						if ($#cmds>0){
							&bcast($cmds[1]);
						}
					}
			case "help"	{
						&server_reply($client_sock,"available commands:");
						&server_reply($client_sock,"threads => number of running threads");
						&server_reply($client_sock,"bcast:<msg> => broadcast message");
						&server_reply($client_sock,"cmd:<cmd> => run command on server");
					}
                	else		{ &server_reply($client_sock,"OK"); }
        	}
	}
	if ($DEBUG){print "client disconnected...";}
	&conn_close($client_sock);
	if ($DEBUG){print "exit thread...".threads->self->tid()."\n";}
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
	$sockets->add($new_sock);
	print "received connection from ".$new_sock->peerhost().":".$new_sock->peerport()."\n";
	$new_sock->autoflush(1);
	binmode $new_sock;
	$t = threads->new(\&new_conn,$new_sock);
	$t->detach();
}

