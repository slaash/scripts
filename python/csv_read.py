#!/opt/python3/bin/python3

import csv

inputFile=open('./file1.csv',newline='')
inputCSV=csv.reader(inputFile,delimiter=',',quotechar='"')

outputFile=open('./file2.csv','w')
outputCSV=csv.writer(outputFile, delimiter=';', quotechar='"', quoting=csv.QUOTE_MINIMAL)

crt_row=0
for row in inputCSV:
	if len(row)==6:
		print(row)
		outputCSV.writerow(row)
	else:
		print("Line "+str(crt_row)+": some garbage found, skipping!")
	crt_row+=1

outputFile.close()
inputFile.close()

