#!/usr/local/bin/python3

import datetime
import time

tstamp=int(time.time())
date=datetime.datetime.fromtimestamp(tstamp)

print(str(tstamp)+":"+str(date))


