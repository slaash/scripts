min=arg[1]
max=arg[2]

cr=coroutine.create(function ()
			for i=min,max do
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
			coroutine.yield()
			end
end)

for i=min,max do
	coroutine.resume(cr,i)
end
