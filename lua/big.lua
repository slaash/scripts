--[[a=1000000000000000
b=a+100

while a<=b do
	print(string.format("%.0f",a))
	a=a+1
end

math.randomseed(os.time())
print(math.random(1000))
--]]

a=1e20
b=a*2
print(b)
for i=a,b do
	print(string.format("%.0f",i))
end

