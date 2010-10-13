#!/usr/bin/ruby

if (ARGV.length>1) then
	first=ARGV[0]
	first.chomp
end
#while (rnd !~ /^#{first}/) do
#while (/^#{first}/.match(rnd.to_s) == nil or rnd.to_s.length<8) do
cnt=0
while (cnt<10) do
	cnt=cnt+1
	rnd=nil
	while (rnd.to_s.length<8) do
		rnd=rand(99999999)
		puts cnt.to_s+": "+rnd.to_s
	end
end
#puts "Found "+rnd.to_s

