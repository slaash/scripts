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

conn = SQLite3::Database.new("/home/virtual2/db/rand.db")

query(conn,"select sqlite_version()")

conn.close

