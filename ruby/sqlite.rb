#!/usr/bin/ruby

require 'sqlite3'
require 'digest/md5'

def useradd(db,uid,*args)
	@db=db
	@uid=uid
	case args.length
	when 0 then
		@name=""
		@shell="/bin/sh"
		@passwd=Digest::MD5.hexdigest(@uid)
	when 1 then
		@name=args[0]
		@shell="/bin/sh"
		@passwd=Digest::MD5.hexdigest(@uid)
	when 2 then
		@name=args[0]
		@shell=args[1]
		@passwd=Digest::MD5.hexdigest(@uid)
	when 3 then
		@name=args[0]
                @shell=args[1]
		@passwd=Digest::MD5.hexdigest(args[2])
	end

	puts "insert into users(uid,name, shell,passwd) values ('"+@uid+"','"+@name+"','"+@shell+"','"+@passwd+"')"	
	@db.execute("insert into users(uid,name, shell,passwd) values ('"+@uid+"','"+@name+"','"+@shell+"','"+@passwd+"')")
end

db = SQLite3::Database.new( "../db/test.db" )

useradd(db,"uidl9004","John Doe3","/bin/bash","asdf13")


rows = db.execute( "select uid,shell from users" )
rows.each do |row|
	puts row
end

