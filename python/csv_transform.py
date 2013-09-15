#!/usr/bin/python

import sys
import csv
import re
import resource

def loadVendorData(MACFile):
	vendors=dict()
        f=open(MACFile)
	pattern=re.compile(r'([A-Z0-9]+)\s(.+)')
	for line in f.readlines():
		m=re.match(pattern,line)
		if m != None:
			vendors[m.groups()[0]]=m.groups()[1]
	f.close()
	print("Loaded MACs")
	return(vendors)

def colToVendor(col,d):
	pattern=re.compile(r'\s*([A-Z0-9]+)\:([A-Z0-9]+)\:([A-Z0-9]+)\:([A-Z0-9]+\:[A-Z0-9]+\:[A-Z0-9]+).*')
	m=re.match(pattern,col)
	if m != None:
		mac=m.groups()[0]+m.groups()[1]+m.groups()[2]
		try:
			col=d[mac]+" ("+m.groups()[3]+")"
		except KeyError:
			pass
	return(col)

fileName=sys.argv[1]
print(fileName)
inCSVFile=open(fileName)
inCSV=csv.reader(inCSVFile,delimiter=',')

outCSVFile=open(fileName+'.new','w')
print(fileName+'.new')
outCSV=csv.writer(outCSVFile,delimiter=',',quoting=csv.QUOTE_MINIMAL)

d=loadVendorData('/usr/share/nmap/nmap-mac-prefixes')

pattern=re.compile(r'([A-Z0-9]+)\:([A-Z0-9]+)\:([A-Z0-9]+)\:[A-Z0-9]+\:[A-Z0-9]+\:[A-Z0-9]+.+')
for row in inCSV:
	cnt=0
	for col in row:
		row[cnt]=colToVendor(col,d)
		cnt=cnt+1
	outCSV.writerow(row)

inCSVFile.close()
outCSVFile.close()

print("Max RSS: "+str(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss)+" kB")

