#!/usr/bin/ruby

min=10000000000000
max=10000000000100

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
	pid=Process.fork
	if (pid==nil) then
		is_prime(i)
		exit
	else
		puts "Running children: "+(running+1).to_s
		running+=1
		if (running==parallel) then
			result=Process.wait()
			running-=1
		end
	end
end

while (Process.wait()!=-1) do end
puts "Done!"

