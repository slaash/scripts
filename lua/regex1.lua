io.input("file.txt")
for line in io.lines() do
	r=string.match(line,"(%d+).+")
	if r ~= nil then
		print(r)
	end
end
io.close()
	
