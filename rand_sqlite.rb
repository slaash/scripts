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
			puts row
		end
		rows
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

conn = SQLite3::Database.new("rand.db")

#init_db(conn)

drop_db(conn)


