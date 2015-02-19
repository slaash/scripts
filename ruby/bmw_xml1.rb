#!/usr/bin/ruby1.8

require 'rexml/document'

doc=REXML::Document.new File.new("bmw_to_CONTI_MM_2010_01_13T18-27-40.xml")

doc.elements.each("MSR-ISSUE/ISSUES/ISSUE") do |elem|
	puts elem.elements["LONG-NAME"].text
	
end


