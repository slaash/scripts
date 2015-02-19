#!/usr/bin/ruby

min=ARGV[0].to_i
max=ARGV[1].to_i

for i in min..max
	prim=1
	for j in 2..Math.sqrt(i)
		if (i % j == 0) then
			prim=0
			break
		end
	end
	if (prim == 1) then
		puts i
	end
end

