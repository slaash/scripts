#!/usr/bin/perl -w
	   
use Net::SMTP_auth;
		      
$smtp = Net::SMTP_auth->new('mail.iasi.rdsmail.ro',Debug=>1);
$smtp->auth('PLAIN', 'rdsmail-socola.tehnic', '123456');
					    
$smtp->mail("socola.tehnic\@iasi.rdsmail.ro");
$smtp->to("rmoisa\@yahoo.com");
							  
$smtp->data();
$smtp->datasend("To: rmoisa@yahoo.com\n");
$smtp->datasend("\n");
$smtp->datasend("A simple test message\n");
$smtp->dataend();
					 
$smtp->quit;
																    