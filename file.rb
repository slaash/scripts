#!/usr/bin/ruby1.9.1

file=open("file.out","w")
while ((input=gets.chomp) != "bye") do
	file.puts input
end
file.close

file=open("file.out","r")
lines=file.readlines
lines.each do |line|
	puts "Line:"+line.chomp
end

