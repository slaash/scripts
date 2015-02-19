#!/usr/bin/ruby
#http://www.bnr.ro/nbrfxrates.xml

require 'net/http'
require 'rexml/document'

resource = Net::HTTP.new("www.bnr.ro",80)
headers,data = resource.get('/nbrfxrates.xml')

doc=REXML::Document.new data

doc.elements.each('DataSet/Body/Cube') do |elem|
	puts elem
end

