#!/usr/bin/ruby

list=[1,2,3,4,5,6]
sorted=Array.new

def insert_elem (elem,list)
	@elem=elem
	@list=list
	inserted=0
	@list.each do |i|
#		puts '...'+i.to_s
#		puts '......'+@elem.to_s
		if (inserted==0) then
			if (i<@elem) then
				puts i.to_s+' smaller'
			else
				puts @elem.to_s+' greater'
				inserted=1
				puts i.to_s+' comes after'
			end
		else
			puts i.to_s+' after inserted=1'
		end
	end
	if (inserted==0) then
		puts @elem.to_s+' inserted last'
	end
end
	
sorted[0]=list[0]
list.each do |i|
	insert_elem(i,sorted)
end

