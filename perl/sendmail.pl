#!/usr/bin/perl

use Net::SMTP;

$mailserver="mail.siemens.de";
$from="radu.moisa\@siemens.com";

open LIST,"lista.txt";
while ($adr=<LIST>){
	chomp $adr;
	$smtp = Net::SMTP->new($mailserver,
                           Hello => $mailserver,
                           Timeout => 30,
                           Debug   => 1,
                          );
	$smtp->mail($from);
	$smtp->to($adr);
	$smtp->data();
    	$smtp->datasend("To: $adr\n");
    	$smtp->datasend("\n");

	$smtp->datasend("MIME-Version: 1.0\n");
	$smtp->datasend("Content-Disposition: attachment; filename=\"atasament.txt\"\n");
	$smtp->datasend("Content-Type: application/text; name= atasament.txt ");
	$smtp->datasend();

	open MAIL,"mesaj.txt";
	while ($line=<MAIL>){
		chomp $line;
    		$smtp->datasend("$line\n");
	}
	close MAIL;
    	$smtp->dataend();
    	$smtp->quit;
}
close LIST;

	
