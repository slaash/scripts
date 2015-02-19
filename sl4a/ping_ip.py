import os,sys

for ip in range(1,255):
	ip='192.168.43.'+str(ip)
	#print(ip)
	code=os.system('ping -c 1 '+ip+' >/dev/null')
	#print(code)
	if (code == 0):
		print(ip)
	else:
		sys.stdout.write('.')
		sys.stdout.flush()

raw_input()
