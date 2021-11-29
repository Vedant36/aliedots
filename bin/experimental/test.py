#!/usr/bin/env python3
import numpy as np
import matplotlib.pyplot as plt

p = 64/1125
qwe=[[1], [0], [0], [0]]
n=100
for i in range(n):
	qwe[0].append(qwe[0][-1]*(1-p))
	qwe[1].append(qwe[0][-1]*p+qwe[1][-1]*(1-p))
	qwe[2].append(qwe[1][-1]*p+qwe[2][-1]*(1-p))
	qwe[3].append(qwe[2][-1]*p+qwe[3][-1])

qwe = np.asarray(qwe)
for i in qwe:
	plt.plot(i/np.arange(1,n+2))
	# plt.plot(i)
print(qwe)
plt.show()

