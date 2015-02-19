#!/usr/bin/ruby

require 'sqlite3'

def query (conn,query)
	@conn=conn
	@query=query
	db_locked=1
	first=1
	while (db_locked==1) do
		db_locked=0
		begin
			rows=@conn.execute(@query)
		rescue
			err_msg=$!.to_s.chomp
			if (err_msg!="database is locked") then
				puts "ERROR QUERY: "+@query
				puts "ERROR MSG:   "+err_msg
			else
				if (first==1) then
	                                puts "ERROR QUERY: "+@query
					puts "ERROR MSG:   "+err_msg
					puts "Retrying..."
					first=0
				end
				db_locked=1
			end
		end
	end
	if (first==0) then
		puts "Got token!"
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

def most_common(conn)
	@conn=conn
	query(conn,"select number,count(number) as cnt from numbers group by number having (count(number)>1) order by cnt desc limit 10")
end

def populate (conn,no)
	@conn=conn
	@no=no
	max=99999999
	puts "Adding "+no.to_s+" values..."
	(0..no).each do |i|
        	val=rand(max).to_s
		if (i % 1000 ==0) then
		        puts i.to_s+": "+val
		end
        	query(conn,"insert into numbers(number) values('"+val+"')")
	end
	puts "Added "+no.to_s+" numbers."
end

def list (conn)
	@conn=conn
	query(conn,"select * from numbers")
end

def count (conn)
	@conn=conn
	query(conn,"select count(id) from numbers")
end

if (ARGV.length==0) then
	puts "Usage: rand_sqlite.rb <no. of values to generate>"
	exit
else
	NO=ARGV.shift.to_i
end

conn = SQLite3::Database.new("../db/rand.db")

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

puts "What's your poison(<p>opulate/<l>ist/<c>ount/<s>tatistic>/<q>uit)?"
while (opt=gets.chomp) do
	case opt
	when "p" then
		populate(conn,NO)
	when "l" then
		list(conn)
	when "q" then
		conn.close
		exit
	when "c" then
		count(conn)
	when "s" then
		most_common(conn)
	else
		puts "Try again(<p>opulate/<l>ist/<c>ount/<s>tatistic>/<q>uit)!"
	end
end

