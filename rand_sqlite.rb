#!/usr/bin/ruby

require 'sqlite3'

def query (conn,query)
	@conn=conn
	@query=query
	rows=@conn.execute(@query)
	rows.each do |row|
		puts row
	end
	rows
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

init_db(conn)

#drop_db(conn)


