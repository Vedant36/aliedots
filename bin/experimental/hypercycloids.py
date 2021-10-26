#!/usr/bin/env python3
import numpy as np
a, b, c = 1, 0.3, 0.1
theta = np.linspace(0, 1, 10000) *8*np.pi
x = (a-b)*np.cos(theta) + c*np.cos(theta*(1-a/b))
y = (a-b)*np.sin(theta) + c*np.sin(theta*(1-a/b))

import matplotlib.pyplot as plt
plt.plot(x, y)
plt.show()


