import csv
import sys, os, datetime

if os.path.isfile(sys.argv[1]):
    csv_file = sys.argv[1]
    with open(csv_file) as inputFile:
        next(inputFile)
        inputCSV = csv.reader(inputFile, delimiter=',')
        for row in inputCSV:
            time, val = row
            print("{}: {} MB".format(datetime.datetime.fromtimestamp(float(time)).strftime('%Y-%m-%d %H:%M:%S'), int(float(val)/1024/1024)))

