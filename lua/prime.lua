#!/usr/bin/lua

min=tonumber(arg[1])
max=tonumber(arg[2])

print("Calculam de la " .. string.format("%.0f",min) .. " la " .. string.format("%.0f",max))

for i=min,max,1 do
	prim=true
	for j=2,math.sqrt(i),1 do
		if math.fmod(i,j)==0 then
			prim=false
			break
		end
	end
	if prim then
		print(string.format("%.0f",i))
	end
end

