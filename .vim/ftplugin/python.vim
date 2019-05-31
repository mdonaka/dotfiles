python3 << EOF
import os
import sys

paths = []
home = os.path.expanduser('~')
paths.append(home + "/anaconda3/envs/env-s/lib/python3.7/site-packages")
paths.append(home + "/anaconda3/lib/python3.6/site-packages")
paths.append("/usr/lib/python3.6/dist-package")

for path in paths:
	if not path in sys.path:
		sys.path.insert(0, path)

EOF

