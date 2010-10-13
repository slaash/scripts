#!/usr/bin/ruby

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

def get_mem_info_by_ps (pid)
	@pid=pid
	cmd=IO.popen("ps -o vsz= -p "+@pid.to_s)
	mem_kb=cmd.gets.to_i
	mem_mb=mem_kb/1024
        "Memory usage ("+@pid.to_s+"): "+mem_kb.to_s+" KB ("+mem_mb.to_s+" MB)."
end
	
puts get_mem_info_by_proc(PID)
puts get_mem_info_by_ps(PID)

