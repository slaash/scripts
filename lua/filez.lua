f=io.open("file.txt","w")
for i=1,11 do
	f:write(i .. "Hello!\n")
end
f:close()

f=io.open("file.txt","r")
for line in f:lines() do
	print(line)
end
f:close()

