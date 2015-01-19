zcat access.log.*.gz|perl -lne 'print $1 if ($_ =~ /.+\s.+\s.+\s\[.+\]\s\".+\"\s.+\s.+\s.+\"(.+)\"$/)'|sort|uniq -c |sort -n
