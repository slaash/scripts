#!/usr/bin/ruby

min=ARGV[0].to_i
max=ARGV[1].to_i

def is_prime(n)
        prim=1
        for i in 2..Math.sqrt(n)
                if (n % i ==0) then
                        prim=0
                        break
                end
        end
        if (prim==1) then
                puts n
        end
end

def check_threads
        run=0
        Thread.list.each do |thr|
                if (thr.status == "run") then
                        run=run+1
                end
        end
#        puts "Runners: "+run.to_s
        return run
end

(min..max).each do |n|
        thr=Thread.new{is_prime(n)}
#       puts Thread.list.length.to_s
        if (check_threads()>5) then
#       if (Thread.list.length>5) then
                thr.join
        end
end

