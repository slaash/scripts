#!/usr/bin/ruby

require 'socket'

sock="/tmp/unixsocketd.sock";
if (File.exists?(sock)) then
	File.unlink(sock)
end

server = UNIXServer.open(sock)
socket=server.accept

while (line=socket.gets) do
	puts "Got "+line
end

