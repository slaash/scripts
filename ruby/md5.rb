#!/usr/bin/ruby

require 'digest/md5'

if (ARGV[0] == nil)
	puts "We need at least one arg!\n"
	exit
end

puts Digest::MD5.hexdigest(ARGV[0])

