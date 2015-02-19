#!/usr/bin/lua

--function values (t)
--      local i = 0
--      return function () i = i + 1; return t[i] end
--end

l={1,2,3,"a","b","c"}
for i=1,#l do
	print(l[i])
end

--for i in values(l) do
--      print(i)
--end

print("----------------------")

for i,j in ipairs(l) do
	print(i,j)
end

print("----------------------")

h={a=1, b=2, c=3}
for k,v in pairs(h) do
	print(k,v)
end

print("----------------------")

m={6,7,8}
n={"f","g","h"}
ex={d1=l, d2=m, d3=n}
for k,v in pairs(ex) do
	print(k)
	for q,w in pairs(v) do
		print(q,w)
	end
end

print("----------------------")

print(ex.d3[1])
print(ex["d3"][1])

print("----------------------")

