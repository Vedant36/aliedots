#!/usr/bin/env python
# Neptune's Pride API documentation: https://forum.ironhelmet.com/t/api-documentation-player-written/7533
import requests
import json
import os
import sys
get=os.environ.get
join=os.path.join

root = "https://np.ironhelmet.com/api"
with open(join(get('XDG_LIB_HOME', '/home/vn36/.local/lib'), 'private', 'neptune_api.json'), 'r') as fp:
	params = json.load(fp)
n = int(sys.argv[1])
payload = requests.post(root, params[n]).json()
with open(join(get('DATASETS'),'neptunes_pride', f'neptune_{n}.json'), 'w') as fp:
	json.dump(payload, fp)

