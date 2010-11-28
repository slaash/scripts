#!/usr/bin/ruby

max=99999999
no=1000
hash=Hash.new
puts "Adding "+no.to_s+" values..."
(0..no).each do |i|
	val=rand(max)
	hash[i]=val
	if (i % 1000 ==0) then
		puts i.to_s+": "+val.to_s
	end
end
