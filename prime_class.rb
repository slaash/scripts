#!/usr/bin/ruby

min=ARGV[0].to_i
max=ARGV[1].to_i

class Integer

	def ePar
		if (self % 2 ==0) then
			true
		else
			false
		end
	end

	def ePrim
		prim=1
		for i in 2..Math.sqrt(self)
			if (self % i ==0) then
				prim=0
				break
			end
		end
		if (prim==1) then
			true
		else
			false
		end
	end
end

for i in min..max
	unless i.ePar then
		if (i.ePrim) then
			puts i
		end
	end
end

