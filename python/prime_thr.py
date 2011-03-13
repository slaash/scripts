#!/usr/bin/python3

import math
import sys
import threading

min=int(sys.argv[1])
max=int(sys.argv[2])

class thr (threading.Thread):
 def __init__ (self,n):
  self.n = n
  threading.Thread.__init__ ( self )

 def run ( self ):
  print("Got: "+self.n)
  is_prime(self.n) 

 def is_prime(n):
  prim=1
  for i in range(2,int(math.sqrt(n)+1)):
   if math.fmod(n,i) == 0:
    prim=0
    break
   if prim == 1:
    print(n)

for i in range(min,max+1):
 t=thr(i)
 runners=threading.active_count()
 print("Active threads: "+str(runners))
 if (runners<=4):
  t.start
 else:
  t.join

