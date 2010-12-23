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

        client.puts("Hello from child"+i.to_s)
        client.close
end

def server(sock)
	@sock=sock
	puts "Parent"
	server = UNIXServer.open(sock)
	while (socket=server.accept) do
		line=socket.gets
       		puts "Got "+line
	end
end

thr=Array.new
thr[0]=Thread.new{server(sock)}
(1..10).each do |i|
	thr[i]=Thread.new{client(i,sock)}
end

thr.each do |i|
	i.join
end

