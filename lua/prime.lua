#!/usr/bin/lua

min=10000000000000
max=10000000001000

for i=min,max do
	prim=1
	for j=2,math.sqrt(i) do
		if i%j==0 then
			prim=0
			break
		end
	end
	if prim==1 then
		print(i)
	end
end

