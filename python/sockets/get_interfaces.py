#!/usr/bin/python3

import array
import struct
import socket
import fcntl

SIOCGIFCONF = 0x8912  #define SIOCGIFCONF
BYTES = 4096          # Simply define the byte size

# get_iface_list function definition 
# this function will return array of all 'up' interfaces 
def get_iface_list():
	# create the socket object to get the interface list
	sck = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

	# prepare the struct variable
	names = array.array('B', '\0'*BYTES)
    
	# the trick is to get the list from ioctl
	bytelen = struct.unpack('iL', fcntl.ioctl(sck.fileno(), SIOCGIFCONF, struct.pack('iL', BYTES, names.buffer_info()[0])))[0]

	# convert it to string
	namestr = names.tostring()

	# return the interfaces as array
	return [namestr[i:i+32].split('\0', 1)[0] for i in range(0, bytelen, 32)]

# now, use the function to get the 'up' interfaces array
ifaces = get_iface_list()

# well, what to do? print it out maybe... 
for iface in ifaces:
	print(iface)
