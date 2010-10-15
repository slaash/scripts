#!/usr/bin/ruby1.8

require 'csv'

filename="EE_MASTER.csv"

file=CSV.open(filename, "r", ";") 
#file.each do |row|
#	puts row[1]+" "+row[2].to_s
#end
array=file.parse
print array[0]
#file.close

