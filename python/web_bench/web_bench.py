#!/usr/bin/python

import httplib
from multiprocessing import Pool
import time
import datetime

srv = "127.0.0.1"
port = "80"
url = "/"
clientsNo = 10
reqsNo = 10000

def sendReq(s, pr, u):
	conn = httplib.HTTPConnection(s + ":" + pr)
	conn.request("GET", u)
#	res = conn.getresponse()
#	print "{} {}".format(res.status, res.reason)
	conn.close()

p = Pool(clientsNo)
time1 = time.time()
for i in range(reqsNo):
	p.apply_async(sendReq, [srv, port, url])
	if i % 1000 == 0:
		print "{}/{} reqs from {} clients".format(i, reqsNo, clientsNo)
p.close()
p.join()
time2 = time.time()
print datetime.timedelta(seconds = time2 - time1)

