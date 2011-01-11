#!/usr/bin/ruby

min=100000000000000
max=100000000000100

def is_prime(n)
	@n=n
	prim=1
        (2..Math.sqrt(@n)).each do |j|
                if (@n%j==0) then
                        prim=0
                        break
                end
        end
        if (prim==1) then
                puts @n
        end
end

parallel = 5
running = 0

(min..max).each do |i|
	if (running<parallel) then
		Process.fork{is_prime(i)}
	else
		Process.wait
	end
end

Process.waitall

