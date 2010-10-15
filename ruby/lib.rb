#!/usr/bin/ruby

def get_used_mem_by_ps (pid)
#returns used memory in KB
        @pid=pid
        cmd=IO.popen("ps -o vsz= -p"+@pid.to_s)
        /(\d+)/=~cmd.gets
        Regexp.last_match(0)
end

def get_free_mem_by_proc
#returns free memory in KB
        file=File.new("/proc/meminfo","r")
        while (line=file.gets) do
                line.chomp
                if (/MemFree:(\s+)(\d+)(\s+)kB/=~line) then
                        break
                end
        end
        file.close
        Regexp.last_match(2)
end

def get_used_mem_by_proc (pid)
#returns used memory in KB
        @pid=pid
        l=Array.new
        file=File.new('/proc/'+$$.to_s+'/stat','r')
        while (line=file.gets) do
                line.chomp
                l=line.split(/ /)
        end
        file.close
	l[22].to_i/1024
end

def get_total_mem_by_proc
#returns free memory in KB
        file=File.new("/proc/meminfo","r")
        while (line=file.gets) do
                line.chomp
                if (/MemTotal:(\s+)(\d+)(\s+)kB/=~line) then
                        break
                end
        end
        file.close
        Regexp.last_match(2)
end

