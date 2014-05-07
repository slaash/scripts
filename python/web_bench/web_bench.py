#!/usr/bin/python

import urllib2
from multiprocessing import Pool, Queue
import threading
import time
import datetime
import sys
import getopt

srv = "127.0.0.1"
port = "80"
url = "/"
clientsNo = 10
reqsNo = 10

class thr (threading.Thread):
	def __init__ (self):
		threading.Thread.__init__ ( self )

	def run (self):
		self.statsTimer()

	def statsTimer(self):
		oC = okCodes.qsize()
		eC = errCodes.qsize()
		while (oC + eC < reqsNo):
			print "{} good reqs, {} errors".format(oC, eC)
			time.sleep(3)
			oC = okCodes.qsize()
			eC = errCodes.qsize()
		print "Timer finished"
		return 0

def sendReq(s, pr, u):
	req = urllib2.Request("http://{}:{}{}".format(s, pr, u))
	req.add_header('User-agent', 'Mozilla/5.0')
	try:
		f = urllib2.urlopen(req, timeout=60)
	except urllib2.URLError, e:
		errCodes.put(e.code)
		return 0
	else:
		okCodes.put("200")#use some get code
		f.close()
		return 0

sys.argv.pop(0)
try:
	optlist, args = getopt.getopt(sys.argv, 's:p:u:c:r:')
	for o, a in optlist:
		if o == '-s':
			srv = a
		elif o == '-p':
			port = a
		elif o == '-u':
			url = a
		elif o == '-c':
			clientsNo = int(a)
		elif o == '-r':
			reqsNo = int(a)
except getopt.GetoptError as err:
	print(err)
	sys.exit()

print "{} reqs for http://{}:{}{} from {} clients".format(reqsNo, srv, port, url, clientsNo)
errCodes = Queue()
okCodes = Queue()
t = thr()
t.start()
p = Pool(clientsNo)
time1 = time.time()
for i in range(reqsNo):
	p.apply_async(sendReq, [srv, port, url])
	if i % 100 == 0:
		print "{}/{} reqs ({} errors) from {} clients".format(i, reqsNo, errCodes.qsize(), clientsNo)
p.close()
p.join()
t.join()
time2 = time.time()
print datetime.timedelta(seconds = time2 - time1)
print "{} good reqs, {} errors".format(okCodes.qsize(), errCodes.qsize())
print "{:.2f} reqs/s".format(reqsNo / (time2 - time1))

