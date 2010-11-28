#!/usr/bin/ruby

max=10
no=100

hash=Hash.new
(0..no).each do |i|
	val=rand(max)
	hash[i]=val
end

array=Array.new
array=hash.sort {|a,b| b[1]<=>a[1]}

count_hash=Hash.new(0)
array.each do |pair|
	count_hash[pair[1]]+=1
	puts pair[0].to_s+' -> '+pair[1].to_s
end

count_array=count_hash.sort
puts 'Counted Values:'
count_array.each do |pair|
	puts pair[0].to_s+' -> '+pair[1].to_s
end

