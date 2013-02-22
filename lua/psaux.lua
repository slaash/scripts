c=io.popen("ps aux")
for line in c:lines() do
	r=string.match(line,"^uidl9555.+")
	if (r ~= nil) then
		print(line)
	end
end
c:close()

