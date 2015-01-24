zcat access.log.*.gz|perl -lne 'print $1 if ($_ =~ /.+\s.+\s.+\s\[.+\]\s\".+\"\s.+\s.+\s.+\"(.+)\"$/)'|sort|uniq -c |sort -n
ps|xargs -P2 -i -t bash -c 'echo {}|perl -ne "print $_ if (/zsh/);"'
echo "HTTP_USER_AGENT=mama"|perl -nle '/(HTTP)/;print $1;'
echo "HTTP_USER_AGENT=mama"|xargs -P2 -t -i -n1 bash -c 'echo {}|perl -nle "/(HTTP)/;print \$1;"'
echo "HTTP_USER_AGENT=mama"|xargs -P2 -i -n1 bash -c 'echo "{}"|perl -nle "if (/^HTTP_USER_AGENT=(.+)/){print \$1;}"'
zcat xxx|xargs -P2 -i -n1 bash -c 'echo "{}"|perl -nle "if (/^HTTP_USER_AGENT=(.+)/){print \$1;}"'
ls xxx|xargs -P8 -i -n1 bash -c 'zcat {}|perl -lne "if (/GET (.+)/){print \$1;}"' | perl -e 'while (<>){$lines{$_}++;}; for (keys %lines){print "$lines{$_} $_";}'

python -c '
import sys
d = {}
for l in sys.stdin:
    d[l] = d.get(l, 0) + 1
for k, v in d.iteritems():
    print v, k,
'

