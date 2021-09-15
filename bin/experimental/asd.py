#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

class Star:
	def __init__(self, x, y):
		self.l = np.array([x, y])
		self.ships = 0

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
			
		

locations = [[0,0],[3,0],[3,4]]
stars = list(Star(*i) for i in locations)
star_info = [[] for i in stars]
carriers = [
		Carrier([stars[0],stars[1]], 0),
		Carrier([stars[1],stars[2]], 0)
		]
carrier_info = [[] for i in carriers]

for i in range(1000):
	for a,b in zip(stars, star_info):
		b.append(a.ships)
		a.ships+=1

	for j in carriers:
		j.move()
	for a,b in zip(carriers, carrier_info):
		b.append(a.ships)

for a,b in zip(stars, star_info):
	b.append(a.ships)

print(star_info[0])
# print(carrier_info)

# for i in star_info:
# 	plt.plot(i)
# plt.show()

