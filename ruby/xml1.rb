#!/usr/bin/ruby1.8

require 'rexml/document'

doc=REXML::Document.new File.new("page.htm")

doc.elements.each('HTML') do |elem|
        puts elem.attributes["TITLE"]
end

doc.elements.each('HTML/TITLE') do |elem|
	puts elem.text
end

