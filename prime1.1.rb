#!/usr/bin/ruby

min=ARGV[0].to_i
max=ARGV[1].to_i

(min..max).each do |i|
	prim=1
	(2..Math.sqrt(i)).each do |j|
		if (i % j == 0) then
			prim=0
			break
		end
	end
	if (prim == 1) then
		puts i
	end
end

