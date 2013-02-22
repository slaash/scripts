io.output("file.txt")
for i=1,10 do
	io.write(i .. "Hello!\n")
end
io.close()

for line in io.lines("file.txt") do
	print(line)
end

