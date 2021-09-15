#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

class Star:
	def __init__(self, x, y):
		self.l = np.array([x, y])
		self.ships = 0

	def __repr__(self):
		return f"{self.l}"

	def __sub__(self, other):
		return np.linalg.norm([self.l, other.l])


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

	def move(self):
		s=self.s
		self.d+= 1
		if self.d>=(s[self.i] - s[(self.i+1)%len(s)]):
			self.d=0
			self.i = (self.i+1)%len(s)
			if self.i==self.drop:
				s[self.i].ships+= self.ships
				self.ships = 0
			else:
				self.ships = s[self.i].ships
				s[self.i].ships = 0
			
		

carrier_scenarios = [
		[[[0,1], 0], [[0,2], 0]],
		[[[0,1], 0], [[1,2], 0]]]

star_info = []
locations = [[0,0],[10,0],[10,10]]

for i in carrier_scenarios:
	stars = list(Star(*i) for i in locations)
	carriers = [ Carrier([stars[k] for k in j[0]], j[1]) for j in i ]
	carrier_info = [[i.ships for i in carriers]]
	star_info.append([stars[0].ships])

	for j in range(100):
		for a,b in zip(stars, star_info):
			b.append(a.ships)
			a.ships+=1

		for k in carriers:
			k.move()
		star_info[-1].append(stars[0].ships)
		carrier_info.append([[i.ships for i in carriers]])

	print(carrier_info)

print(np.asarray(star_info))

# for i in star_info:
# 	plt.plot(i)
# plt.show()

