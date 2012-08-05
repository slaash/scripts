import socket

host=socket.getfqdn()

addr=socket.gethostbyname(host)

print("{0} {1}".format(host,addr))
