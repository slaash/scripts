#!/usr/bin/python

import sys,os,random,math

def gen_list(m):
	l=list()
	for n in range(0,m-1):
		try:
			l.append(random.randint(0,m))
		except MemoryError,err:
			print('Out of memory? ',err)
#		if (n%int(math.sqrt(m))==0):
#			sys.stdout.write('.')
#			sys.stdout.flush()
	return l

random.seed()

d=dict()
max=10
if (len(sys.argv[1:])>=1):
	max=int(sys.argv[1])
l=[0]*max

for i in range(0,max-1):
	try:
		d[i]=gen_list(max)
	except MemoryError,err:
	        print('Out of memory? ',err)
	if (i%int(math.sqrt(max))==0):
		sys.stdout.write('+')
		sys.stdout.flush()

print("\nDone: %i x %i" % (i+1,max))
os.system('free -m')
print('Press key...')
raw_input()

