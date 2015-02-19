#!/usr/bin/perl

$forks = 0;
while ($forks<12)
{
    if($forks<10)
    {
        $pid = fork();
        if($pid==0)
        {
#            print "$forks: hello from thread $forks\n";
            exit;
        }
        else
        {
	    print "$pid\n";
            $forks++;
        }
    }
    else
    {
        $dec=wait();
	print "$dec deceased\n";
        $pid = fork();
        if($pid==0)
        {
#            print "hello from delayed thread $forks\n";
            exit;
        }
    }
}

