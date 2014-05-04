#!/usr/bin/python

import urllib2
from multiprocessing import Pool, Queue
import time
import datetime
import sys
import getopt

srv = "127.0.0.1"
port = "80"
url = "/"
clientsNo = 10
reqsNo = 10

def sendReq(s, pr, u):
	req = urllib2.Request("http://{}:{}{}".format(s, pr, u))
	try:
		urllib2.urlopen(req)
	except urllib2.URLError, e:
		codes.put(e.code)

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
codes = Queue()
p = Pool(clientsNo)
time1 = time.time()
for i in range(reqsNo):
	p.apply_async(sendReq, [srv, port, url])
	if i % 100 == 0:
		print "{}/{} reqs ({} errors) from {} clients".format(i, reqsNo, codes.qsize(), clientsNo)
p.close()
p.join()
time2 = time.time()
print datetime.timedelta(seconds = time2 - time1)
print "{} errors".format(codes.qsize())
print "{:.2f} reqs/s".format(reqsNo / (time2 - time1))

