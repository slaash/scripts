#!/usr/bin/ruby

pid=$$
l=Array.new
file=File.new('/proc/'+$$.to_s+'/stat','r')
while (line=file.gets) do
line.chomp
l=line.split(/ /)
#puts line
end
file.close
mem_kb=l[22].to_i/1024
puts 'Memory usage ('+pid.to_s+'): '+mem_kb.to_s+' KB.'

