#!/usr/bin/ruby

def formatLine line
	newline=line.gsub(/\s+/," ");
	fields=newline.split(" ")
	fields[0]+" "+fields[10]
end

rez=open("|ps aux")

while (!rez.eof) do
	line=rez.gets.chomp
	if (/^root/.match(line))
		puts "Formated line "+rez.lineno.to_s+": "+formatLine(line)
	end
end

rez.close

