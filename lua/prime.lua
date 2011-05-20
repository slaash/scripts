#!/usr/bin/lua

min=arg[1]
max=arg[2]

print("Calculam de la "..min.." la "..max)

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

