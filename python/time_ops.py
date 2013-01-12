#!/usr/local/bin/python3

import datetime
import time

tstamp_1=time.time()
time.sleep(3)
tstamp_2=time.time()

delta=datetime.datetime.fromtimestamp(int(tstamp_2)) - datetime.datetime.fromtimestamp(int(tstamp_1))

print(str(delta))


