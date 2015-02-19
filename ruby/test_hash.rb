#!/usr/bin/ruby

hash=Hash.new

(0..10).each do |i|
	array=Array.new(11)
	(0..10).each do |j|
		array[j]=j
	end
	hash[i]=array
end

arr=Array.new
hash.each_key do |key|
	puts hash[key]
end

