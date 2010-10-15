#!/usr/bin/ruby1.9.1

#rez=`ps aux`
#puts rez

rez=open("|ps aux")
foo=rez.readlines

foo.each do |line|
	puts "Line: "+line
end

rez.close
