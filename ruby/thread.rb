#!/usr/bin/ruby

def worker
	(1..100000000).each do |i|
	end
	puts "Thread done"
end

t=fork{worker}
puts "Started Thread!"
Process.waitall

