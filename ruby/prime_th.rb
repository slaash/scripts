#!/usr/bin/ruby

min=ARGV[0].to_i
max=ARGV[1].to_i
nr_threads=ARGV[2].to_i

interval=(max-min)/nr_threads

def primes_on_interval(min,max)
	@min=min
	@max=max
	for i in @min..@max
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
end

all_interv=Array.new
(min..max). do |i|

end

#primes_on_interval(min,max)

all_interv.each do |arr|
	puts arr[0].to_s+" .. "+arr[1].to_s
end

