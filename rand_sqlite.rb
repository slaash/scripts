#!/usr/bin/ruby

require 'sqlite3'

def query (conn,query)
	@conn=conn
	@query=query
	begin
		rows=@conn.execute(@query)
		
	rescue
		puts "ERROR QUERY: "+@query
		puts "ERROR MSG:   "+$!
	end
	if (rows) then
		rows.each do |row|
			(0..row.length).each do |col|
				print row[col].to_s+"\t"
			end
			puts ""
		end
		rows
	else
		-1
	end
end

def init_db (conn)
	@conn=conn
	query(conn,"create table numbers(id INTEGER PRIMARY KEY AUTOINCREMENT, number INTEGER, times INTEGER)")
end	

def drop_db (conn)
	@conn=conn
	query(conn,"drop table numbers");
end

def populate (conn,no)
	@conn=conn
	@no=no
	max=99999999
	puts "Adding "+no.to_s+" values..."
	(0..no).each do |i|
        	val=rand(max).to_s
	        puts i.to_s+": "+val
        	query(conn,"insert into numbers(number) values('"+val+"')")
	end
end

def list (conn)
	@conn=conn
	query(conn,"select * from numbers")
end

if (ARGV.length==0) then
	puts "Usage: rand_sqlite.rb <no. of values to generate>"
	exit
else
	NO=ARGV.shift.to_i
end

conn = SQLite3::Database.new("rand.db")

if (init_db(conn) == -1) then
	puts "Db already existing! Do you want to drop(y/n)?"
	while (opt=gets.chomp) do
		case opt
		when "y" then
			drop_db(conn)
			init_db(conn)
			puts "Db re-initialized"
			break
		when "n" then
			puts "Db not re-initialized"
			break
		else
			puts "Please answer with y or n!"
		end
	end
else
	puts "Db created"
end

puts "What's your poison(<p>opulate/<l>ist/<q>uit)?"
while (opt=gets.chomp) do
	case opt
	when "p" then
		populate(conn,NO)
	when "l" then
		list(conn)
	when "q" then
		conn.close
		exit
	else
		puts "Try again(<p>opulate/<l>ist/<q>uit)!"
	end
end

