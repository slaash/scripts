#!/usr/bin/ruby
#this is why ruby rocks

pid=fork

if (pid == nil) then
	puts "Child"
	while (1) do
	end
else
	Process.detach(pid)
	puts "parent"
	puts "child: "+pid.to_s
end

