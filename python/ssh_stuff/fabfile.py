#!/usr/bin.python

from fabric.api import run
from fabric.operations import open_shell

def host_info():
	run('uname -a')

def openShell():
	open_shell()

