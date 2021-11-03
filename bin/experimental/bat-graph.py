#!/usr/bin/env python
import os
import numpy as np
import matplotlib.pyplot as plt

with open(os.getenv("HOME")+'/.local/var/log/batinfo.log', 'r') as fp:
	data = [[int(j) for j in i.split()] for i in fp.read().split('\n')[:-1]]
	x, y = np.asarray(data, dtype=int)[-100:,:].T

for i in range(1,10):
	plt.plot(np.clip(100/(y[i:]-y[:-i]),-25,10))

plt.plot(y)

plt.show()

