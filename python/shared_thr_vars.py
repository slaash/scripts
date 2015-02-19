#!/usr/bin/python3

import threading
import time
import random

n=0

class thr (threading.Thread):
 def __init__ (self):
  threading.Thread.__init__ ( self )

 def run ( self ):
  global n
  print(self.name+": "+str(n))
  wait=random.randint(1,10)
  print(self.name+": "+"waiting for "+str(wait)+" s")
  time.sleep(wait)
  n=n+1
  print(self.name+": "+str(n))

for i in range(0,9):
 t=thr()
# t.daemon=True
 t.start()
# t.join()

print(n)

