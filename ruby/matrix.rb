#!/usr/bin/ruby

require 'matrix'

m=Matrix[[12,23],[23,46],[45,54]]
n=Matrix[[1,1],[1,1]]

for i in 0..m.row_size-1
	for j in 0..m.column_size-1
		print m[i,j].to_s+","
	end
	print "\n"
end

