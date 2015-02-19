#!/usr/bin/ruby

QUIET=1
HEAD=20

PID=Process.pid

def get_mem_info_by_proc (pid)
        @pid=pid
        l=Array.new
        file=File.new('/proc/'+$$.to_s+'/stat','r')
        while (line=file.gets) do
                line.chomp
                l=line.split(/ /)
        end
        file.close
        mem_kb=l[22].to_i/1024
        mem_mb=mem_kb/1024
        "Memory usage ("+@pid.to_s+"): "+mem_kb.to_s+" KB ("+mem_mb.to_s+" MB)."
end

NO=ARGV.shift.to_i
MAX=ARGV.shift.to_i
MAX=2**4196

file=open("/home/rmoisa/db/random.out","w")

file.puts get_mem_info_by_proc(PID)
file.puts 'Generating '+NO.to_s+' random numgers between 0 and '+MAX.to_s
puts 'Generating random numbers...'
hash=Hash.new
(0..NO).each do |i|
	val=rand(MAX)
	if (i % 1000 ==0) then
		puts i.to_s+": "+val.to_s
	end
	hash[i]=val
end

file.puts get_mem_info_by_proc(PID)
file.puts 'Sorting by generated number value...'
puts 'Sorting by generated number value...'
array=Array.new
array=hash.sort {|a,b| b[1]<=>a[1]}

hash.clear

file.puts get_mem_info_by_proc(PID)
file.puts 'Counting generated numbers...'
puts 'Counting generated numbers...'
count_hash=Hash.new(0)
cnt=0
array.each do |pair|
	count_hash[pair[1]]+=1
	if (QUIET==1) then
		if (cnt<HEAD) then
			file.puts "Pos.\t"+pair[0].to_s+":\tNo.\t"+pair[1].to_s
			cnt+=1
		end
	else
		file.puts "Pos.\t"+pair[0].to_s+":\tNo.\t"+pair[1].to_s
	end
end

array.clear

file.puts get_mem_info_by_proc(PID)
file.puts 'Sorting by appearance number...'
puts 'Sorting by appearance number...'
count_array=Array.new
count_array=count_hash.sort {|a,b| b[1]<=>a[1]}

count_hash.clear

file.puts get_mem_info_by_proc(PID)
file.puts 'Listing counted values...'
puts 'Listing counted values...'
file.puts 'Counted Values:'
cnt=0
count_array.each do |pair|
	if (QUIET==1) then
		if (cnt<HEAD) then
			file.puts "\t\tNo.\t"+pair[0].to_s+":\t"+pair[1].to_s+"\ttimes"
			cnt+=1
		end
	else
		file.puts "\t\tNo.\t"+pair[0].to_s+":\t"+pair[1].to_s+"\ttimes"
	end
end

count_array.clear

file.close


