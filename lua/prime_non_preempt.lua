#!/usr/bin/lua

min=arg[1]
max=arg[2]

threads={}

function isPrime(n)
--	print("Started " .. n)
	local co=coroutine.create(function()
		prim=true
		for j=2,math.sqrt(n) do
			if math.fmod(n,j)==0 then
				prim=false
				break
			end
		end
		if prim then
			print(string.format("%.0f",n))
		end
end)
	table.insert(threads,co)
--	print("Finished " .. n)
end

function dispatch()
	local i=1
	while true do
		if threads[i] == nil then
			if threads[1] == nil then
				break
			end
			i=1
		end
		local status,res=coroutine.resume(threads[i])
		if not res then
			table.remove(threads,i)
		else
			i=i+1
		end
	end
end

print("Calculam de la " .. string.format("%.0f",min) .. " la " .. string.format("%.0f",max))

for i=min,max do
	isPrime(i)
end

dispatch()

