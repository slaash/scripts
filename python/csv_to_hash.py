#!/opt/python3/bin/python3

import csv
import sys

inputFile=open('./file1.csv',newline='')
inputCSV=csv.reader(inputFile,delimiter=',',quotechar='"')

crt_row=0
array=[]
for row in inputCSV:
	if len(row)==6:
		cnt=0
		hash={}
		for item in row:
			hash[cnt]=row[cnt]
			cnt+=1
		array.append(hash)
	else:
		print("Line "+str(crt_row)+": some garbage found, skipping!")
	crt_row+=1

inputFile.close()

print(array)

sys.stdin.readline()

