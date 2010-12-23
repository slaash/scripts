#!/usr/bin/ruby

require 'socket'

sock="/tmp/unixsocketd.sock";
if (File.exists?(sock)) then
        File.unlink(sock)
end

def client(i,sock)
	@i=i
	@sock=sock
	puts "Child "+@i.to_s
	while (!(File.exists?(@sock))) do
        end
	client = UNIXSocket.open(@sock)
	line=client.gets
	client.puts "Child "+i.to_s+" got: "+line
	puts "Client "+i.to_s+" exit"
end

thr=Array.new
(1..10).each do |i|
	thr[i]=Thread.new{client(i,sock)}
end

puts "Main here!"

server=UNIXServer.open(sock)
while(socket=server.accept) do
	print "Input: "
	input=gets
	socket.puts(input)
	while(line=socket.gets) do
		puts "Server got: "+line
	end	
end

