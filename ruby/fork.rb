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

puts "Parent"
server = UNIXServer.open(sock)
socket=server.accept

(1..10).each do |i|
        fork{client(i,sock)}
end

while(1) do
while (line=socket.gets) do
        puts "Got "+line
end
end
