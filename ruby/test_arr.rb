#!/usr/bin/ruby

array=Array.new

(0..10).each do |i|
	data=Array.new
	(0..10).each do |j|
		data[j]=j
	end
	array[i]=data
end

array.each do |arr|
	puts arr
end

