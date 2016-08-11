import subprocess

cmd = subprocess.check_output(['uname', '-a'])
print(cmd.decode("utf-8").rstrip())

