#!/usr/bin/python

import smtplib
import os
import time

unumber = os.getuid()
pnumber = os.getpid()
where = os.getcwd()
what = os.uname()
used = os.times()
now = time.time()
means = time.ctime(now)

#print "User number",unumber
#print "Process ID",pnumber
#print "Current Directory",where
#print "System information",what
#print "System information",used

#print "\nTime is now",now
#print "Which interprets as",means


sender='rmoisa@yahoo.com'
receivers=['radu.moisa@continental-corporation.com']

message="""From: Radu Moisa <rmoisa@yahoo.com>
To: Radu Moisa <radu.moisa@continental-corporation.com>
Subject: Test

Test from Symbian!
","User number",unumber,"Process ID",pnumber,"Current Directory",where,"System information",what,"\nTime is now",now,"Which interprets as",means,"""

smtp=smtplib.SMTP('SMTPHub07.conti.de')
smtp.sendmail(sender,receivers,message)
print "Am dat mailul!"

