#!/usr/bin/python3

import re, sys

m=re.search("ama","mama")
print(m.group())

text="""1
2
3
4
5
6
"""

m=re.findall("\d+",text)
for i in m:
	print(i)

htext="""<div id="psearchres">


<p>You have searched for packages that names contain <em>aircrack</em> in all suites, all sections, and all architectures.


Found <strong>1</strong> matching packages.</p>










  <h3>Package aircrack-ng</h3>
  <ul>

    <li class="hardy"><a class="resultlink" href="/en/hardy/aircrack-ng">hardy</a> (net):
        wireless WEP/WPA cracking utilities [<strong class="pmarker" title="Community maintained open source software">universe</strong>]

      <br>1:1.0~beta1-1: amd64 i386


    </li>

    <li class="lucid"><a class="resultlink" href="/en/lucid/aircrack-ng">lucid</a> (net):
        wireless WEP/WPA cracking utilities [<strong class="pmarker" title="Community maintained open source software">universe</strong>]

      <br>1:1.0-1: amd64 i386


    </li>

    <li class="oneiric"><a class="resultlink" href="/en/oneiric/aircrack-ng">oneiric</a> (net):
        wireless WEP/WPA cracking utilities [<strong class="pmarker" title="Community maintained open source software">universe</strong>]

      <br>1:1.1-1.1build1: amd64 i386


    </li>

    <li class="quantal"><a class="resultlink" href="/en/quantal/aircrack-ng">quantal</a> (net):
        wireless WEP/WPA cracking utilities [<strong class="pmarker" title="Community maintained open source software">universe</strong>]

      <br>1:1.1-4: amd64 i386


    </li>

    <li class="raring"><a class="resultlink" href="/en/raring/aircrack-ng">raring</a> (net):
        wireless WEP/WPA cracking utilities [<strong class="pmarker" title="Community maintained open source software">universe</strong>]

      <br>1:1.1-5: amd64 i386


    </li>

  </ul>

</div>
"""
#print(htext)
pattern=re.compile(r'<div id="psearchres">(.+)</div>', re.MULTILINE|re.DOTALL)
#pattern=re.compile(r'(.+)')
m=re.match(pattern, htext)
print(m.group())

mail=sys.argv[1]
pattern=re.compile(r'.+@(uberresearch|digital-science)\.com')
print(mail, pattern)
if pattern.match(mail):
    print('Matched!')
else:
    print('Mumul')

