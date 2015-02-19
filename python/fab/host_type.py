from fabric.api import run, env, task, execute, runs_once

@task
def host_info():
	uname = run('uname -a')
	mem = run('free -m')
	return(uname + mem)
@task
def proc_list():
	return run('ps aux')

@task
@runs_once
def gather_info():
	info = execute(host_info)
	ps_list = execute(proc_list)
	print (info + ps_list)

env.hosts=['192.168.172.100','192.168.172.200:22222']
print("Executing on %s as %s" % (env.host, env.user))

