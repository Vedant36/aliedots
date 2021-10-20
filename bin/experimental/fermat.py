#!/usr/bin/env python3
import numpy as np

x, y = [], []
# x, y = np.asarray([[i, len({j**3%i for j in range(i)})] for i in range(1,1000)]).T

data={}
for i in [1,2,4,8,16,32,64,128,256]:
	rem={j**4%i for j in range(i)}
	# qwe.append(i-len(rem))
	if i!=len(rem):
		data[i]=rem
		x.append(i)
		y.append(i-len(rem))
x, y = np.asarray(x), np.asarray(y)
print(np.asarray([x,y]).T.tolist())
print(data)

# import matplotlib.pyplot as plt
# plt.scatter(x, y/x, s=1)
# plt.show()

