#!/usr/bin/env python3

import numpy as np
import os

with open(os.getenv('LOG')+'/wak') as fp:
	a = fp.read().split('\n')[:-1]
	asd = np.asarray(a, dtype=int)

import matplotlib.pyplot as plt
# 48813
based=48740
hmm=10
x = np.sort(np.diff(asd))
_x, _y = np.unique(x, return_counts=1)
print(np.mean(x[based:-hmm]), x[based], x[-hmm])
# plt.plot(x[based:])
# plt.plot(20000*np.ones(len(x)-based))
# plt.plot(_x[based:], _y[based:])

prev=asd[0]
qwe=[]
for i in asd[1:]:
	if i-prev>20000:
		qwe.append(prev)
	prev=i
# print(qwe)
b = np.sort(np.diff(qwe))
# print(b, flush=True)
print(np.mean(b))
# plt.plot(b)

# plt.show()

