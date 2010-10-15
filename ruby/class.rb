#!/usr/bin/ruby1.8

require 'csv'

class VWCSVReader

	def initialize(file,mode)
		@file=file
		@mode=mode
		puts "Got file "+@file+" in mode "+@mode
	end

	def openCSV
		@csvfile=CSV.open(@file, @mode, ';')
		puts "Opened file "+@file
	end

	def closeCSV
		@csvfile.close
		puts "Closed file "+@file
	end

	def getVWNumbers
		@csvfile.each do |row|
			puts row[1]
		end
	end

	def printLine(lineno)
		@lineno=lineno
		puts lineno
	end

	def copyToCSV(newfile,lineno)
		@newfile=newfile
		@lineno=lineno
	end

end

eemaster=VWCSVReader.new('EE_MASTER.csv','r')
eemaster.openCSV
#eemaster.getVWNumbers
eemaster.printLine(10)
eemaster.copyToCSV("newfile.csv",10)
eemaster.closeCSV

