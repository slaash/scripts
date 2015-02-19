threads={}

function getNumber()
	local time=os.time()
	local co=coroutine.create(function ()
					local i=1
					while i<=1000000000 do
						if (i%123524==0) then
							print(time)
						end
						i=i+1
					end
				end)
	table.insert(threads,co)
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
--		print(status,res)
		if not res then
			table.remove(threads,i)
		else
			i=i+1
		end
	end
end

for i=1,4 do
	getNumber()
end

--dispatch()

for i=1,#threads do
	print("Resume " .. i)
	coroutine.resume(threads[i])
end

