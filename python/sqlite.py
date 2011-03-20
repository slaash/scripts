#!/opt/python3/bin/python3

import sys
import sqlite3

def query(conn,q):
        rez=''
        try:
                with conn:
                        rez=conn.execute(q)
        except:
                print("SQLite error at: "+q+"\n")
        conn.commit
        for row in rez:
                print(row)

file=sys.argv[1]

print("Using "+file+" as database")

conn=sqlite3.connect(file)

#query(conn,"drop table test")
#query(conn,"CREATE TABLE test(id int primary key asc,name text,value int)")
#query(conn,"insert into test(name,value) values ('a',1)")
query(conn,"select * from test")

conn.close

