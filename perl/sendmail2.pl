#!/usr/bin/perl

use MIME::Lite;
use Net::SMTP;
use Net::SMTP_auth;

#modifica de aici:
my $from_address = 'socola.tehnic@iasi.rdsmail.ro';
my $mail_host = 'mail.iasi.rdsmail.ro';
my $subject = 'Test mail';
my $path = './802-1958.pdf';
my $file = '802-1958.pdf';
$user="rdsmail-socola.tehnic";
$pass="123456";
#pana aici !


my $message_body="";
open MESAJ,"mesaj.txt";
while ($line=<MESAJ>){
	chomp $line;
	$message_body .= "$line\n";
}
close MESAJ;
open LIST,"lista.txt";
while ($to_address=<LIST>){
	chomp $to_address;
	$msg = MIME::Lite->new (
	From => $from_address,
	To => $to_address,
	Subject => $subject,
	Type =>'multipart/mixed'
	) or die "Error creating multipart container: $!\n";

#	$msg->attach (
#	Type => 'TEXT',
#	Data => $message_body
#	) or die "Error adding the text message part: $!\n";

#	$msg->attach (
#	Type => 'application/binary',
#	Path => $path,
#	Filename => $file,
#	Disposition => 'attachment'
#	) or die "Error adding $file_gif: $!\n";

	MIME::Lite->send('smtp', $mail_host, Timeout=>60, Debug=>1, Auth=>"PLAIN", AuthUser=>$user, AuthPass=>$pass);
#	MIME::Lite->send('smtp', $mail_host, Timeout=>60, Debug=>1);
	$msg->send();
	print "Am trimis mail la $to_address.\n";
}
close LIST;
