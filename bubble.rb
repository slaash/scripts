#!/usr/bin/ruby

require './lib.rb'

size=ARGV.shift.to_i

PID=Process.pid

array=Array.new(size+1)
(0..size).each do |i|
	data=Array.new(size+1)
	(0..size).each do |j|
		data[j]=j
	end
	array[i]=data
	puts "Pushed "+(i+1).to_s+" "+data.length.to_s+"-elements list to master array ("+array.length.to_s+" elements)"
        puts "Using "+get_used_mem_by_proc(PID).to_s+" KB from "+get_total_mem_by_proc+" KB ("+get_free_mem_by_proc+" KB free)"
end

input=gets

