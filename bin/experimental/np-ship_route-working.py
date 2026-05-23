#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

class Star:
	def __init__(self, x, y):
		self.l = np.array([x, y])
		self.ships = 0

	def __repr__(self):
		return f"{self.l}"

	def tick(self):
		self.ships += 1

class Carrier:
	def __init__(self, loop_stars, drop_star_index):
		self.s = loop_stars
		self.i = 0 # last star visited by the carrier
		self.drop = drop_star_index
		self.d = 0
		self.ships = self.s[0].ships
		self.s[0].ships = 0

	def __repr__(self):
		return f"Carrier {self.i} {self.d} {self.s}"

	def tick(self):
		s=self.s
		self.d+= 1
		if self.d >= np.linalg.norm([s[self.i].l - s[(self.i+1)%len(s)].l])/(0.5/12):
			self.d=0
			self.i = (self.i+1)%len(s)
			if self.i==self.drop: # drop all
				s[self.i].ships+= self.ships
				self.ships = 0
			else: # collect all
				self.ships = s[self.i].ships
				s[self.i].ships = 0


locations = [[1.165,-0.753], [1.412,-0.806], [1.711,-0.789], [1.710, -0.554]]
stars = list(Star(*i) for i in locations)
star_info = [[] for i in stars]
carriers = [
	Carrier([stars[1], stars[0]],           0),
	Carrier([stars[3], stars[1], stars[2]], 0)
]
carrier_info = [[] for i in carriers]

for i in range(3000):
	for i in range(len(stars)):
		stars[i].tick()
		star_info[i].append(stars[i].ships)

	for i in range(len(carriers)):
		carriers[i].tick()
		carrier_info[i].append(carriers[i].ships)

# print(star_info)
# print(carrier_info)
strategies = [star_info[3].copy()]

stars = list(Star(*i) for i in locations)
star_info = [[] for i in stars]
carriers = [
	Carrier([stars[1], stars[2], stars[3], stars[0]], 2),
	Carrier([stars[3], stars[0], stars[1], stars[2]], 0)
]
carrier_info = [[] for i in carriers]
print(star_info, carrier_info)

for i in range(3000):
	for i in range(len(stars)):
		stars[i].tick()
		star_info[i].append(stars[i].ships)

	for i in range(len(carriers)):
		carriers[i].tick()
		carrier_info[i].append(carriers[i].ships)

strategies.append(star_info[3])

stars = list(Star(*i) for i in locations)
star_info = [[] for i in stars]
carriers = [
	Carrier([stars[1], stars[2], stars[3], stars[0]], 2),
]
carrier_info = [[] for i in carriers]
print(star_info, carrier_info)

for i in range(3000):
	for i in range(len(stars)):
		stars[i].tick()
		star_info[i].append(stars[i].ships)

	for i in range(len(carriers)):
		carriers[i].tick()
		carrier_info[i].append(carriers[i].ships)

strategies.append(star_info[3])

for n, i in enumerate(strategies):
	plt.plot(i, label=f"no {n}")
plt.legend()
plt.show()

