#!/usr/bin/python3

import math
import sys
import threading
import datetime

min=int(sys.argv[1])
max=int(sys.argv[2])

class thr (threading.Thread):
 def __init__ (self,n):
  threading.Thread.__init__ ( self )
  self.n = n

 def run ( self ):
  is_prime(self.n) 

def is_prime(n):
 prim=1
 for i in range(2,int(math.sqrt(n))+1):
  if n % i == 0:
   prim=0
   break
 if prim == 1:
  print(datetime.datetime.fromtimestamp(n))
 return 0

for i in range(min,max+1):
 t=thr(i)
 t.start()
 runners=threading.active_count()
 if runners>4:
  t.join()

