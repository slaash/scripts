#!/usr/bin/ruby

require 'net/ssh'

Net::SSH.start('localhost', 'slash', :password => "nokia13") do |ssh|

output = ssh.exec!("hostname")

stdout = ""
ssh.exec!("ls -l /home/jamis") do |channel, stream, data|
  puts channel
  puts stream
  puts data
end
