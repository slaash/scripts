#!/usr/bin/ruby

require 'socket'

sock="/tmp/unixsocketd.sock";

client = UNIXSocket.open(sock)

while (line=gets) do
	client.puts(line)
end

