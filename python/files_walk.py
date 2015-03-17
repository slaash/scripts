import os

for root, dirs, files in os.walk('/etc'):
	for d in dirs:
		for f in files:
			print os.path.join(root, d, f)

