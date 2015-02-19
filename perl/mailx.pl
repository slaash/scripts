#!/usr/bin/perl -I/home/ccm_root/perl/modules_P5

use strict;
use warnings;
use MIME::Lite;

if ($#ARGV!=2){
	print "usage: mailx.pl \"subject\" recipient1,recipient2 file.txt\n";
	exit;
}

my $subj=$ARGV[0];
my $bcc=$ARGV[1];
my $file=$ARGV[2];

open my $f, "<",$file;
my $file_contents = do { local $/; <$f> };
close $f;

my $from_address = 'ccm_root@continental-corporation.com';
my $mail_host = 'smtphub07.conti.de';
my $subject = $subj;

my $msg = MIME::Lite->new (
	From => $from_address,
	Bcc => $bcc,
	Subject => $subject,
	Type =>'multipart/mixed'
)or die "Error creating multipart container: $!\n";

$msg->attach (
	Type => 'TEXT',
	Data => $file_contents
)or die "Error adding the text message part: $!\n";

MIME::Lite->send('smtp', $mail_host, Timeout=>60);

$msg->send;

