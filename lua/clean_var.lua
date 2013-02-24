to_remove={".old",".1",".gz"}

f=io.popen("ls /var/log/")
for l in f:lines() do
	for i=1,#to_remove do
		if (string.match(l,".+" .. to_remove[i] .. "$")) then
			print(l)
		end
	end
end
f:close()

