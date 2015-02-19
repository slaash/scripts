#!/usr/bin/ruby1.9.1

require 'rexml/document'

doc=REXML::Document.new File.new("/home/slash/scripts/allagents.xml")

agents=Array.new

doc.elements.each('user-agents/user-agent') do |elem|
#	if (/Mozilla/.match(elem.text('String')) and /Windows/.match(elem.text('String')) and elem.text('Type')=='B') then
	if (/Mozilla/.match(elem.text('String')) and /Windows/.match(elem.text('String'))) then
		agents.push(elem.text('String'))
	end
end

#agents.each do |line|
#	puts line
#end

puts "Found "+agents.length.to_s+" agents"

lucky=agents[rand(agents.length)]
puts "Lucky one: "+lucky

file=File.new("/etc/privoxy/match-all.action","r")
file_new=File.new("/home/slash/scripts/match-all.action_new","w")
while (line=file.gets)
	line.chomp
	if (/hide-user-agent\{(.+)\}/.match(line)) then
		newline=" +hide-user-agent{"+lucky+"} \\"
		puts "Changing "
		puts line
		puts "to"
		puts newline
		file_new.puts(newline)
	else
		file_new.puts(line)
	end
end
file_new.close
file.close

`mv /home/slash/scripts/match-all.action_new /etc/privoxy/match-all.action`
