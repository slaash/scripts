#!/usr/bin/ruby

class Integer

min=ARGV[0].to_i
max=ARGV[1].to_i

for i in min..max
	if (i.prime == true) then
		puts i
	end
end

