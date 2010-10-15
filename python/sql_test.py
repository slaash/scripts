#!/usr/bin/python

import sqlite3

conn = sqlite3.connect('/home/uidl9555/scripts/sqlite/test.db')
c = conn.cursor()
c.execute('select * from files')
for row in c:
	print row[0]
c.close

