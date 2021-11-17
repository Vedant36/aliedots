#!/usr/bin/env python3

import numpy as np
import json

class Carrier:
	def __init__(self, order, pos=None):
		self.drop_index = loop[0]
		self.loop = loop[1:]
		self.index = index
		self.time_to_target = time_to_target
		self.ships = 0
		self.distances = [distance( self.loop[i], self.loop[(i+1)%len(self.loop)] ) for i in range(len(self.loop))]

	def __repr__(self):
		return f"Carrier(loop={self.loop}, index={self.index})"

class Star:
	def __init__(self, name, x, y):
		self.name = name
		self.x = x
		self.y = y
		self.ships = 0

	def __repr__(self):
		return f"Star(name={self.name}, x={self.x}, y={self.y})"

	def __eq__(self, other):
		return self.name == other.name

def load_Stars(star_names):
	with open("/home/vn36/dox/_Other/datasets/neptunes_pride/neptune_3.json", 'r') as f:
		data = json.load(f)["scanning_data"]
		stars = data["stars"]

		for value in stars.values():
			if value["n"] in star_names:
				star_names.remove(value["n"])
				yield Star(value["n"], float(value["x"]), float(value["y"]))

				if len(star_names) == 0:
					break

def distance(a, b):
	fleet_speed = 5./120.
	return np.ceil(np.sqrt((a.x - b.x)**2 + (a.y - b.y)**2) / fleet_speed)

def main():
	names = [ "Menkab", "Muphrid", "Biham", "Arided", "Canopus", "Alniyat" ]
	stars = list(load_Stars(names))
	end_point = -1
	# Order: ['Menkab', 'Muphrid', 'Canopus', 'Arided', 'Biham', 'Alniyat']

	num = 100
	carrier_choices = [
		[ [ 4, [ 1, 4, 0 ] ], [ 3, [ 4, 3 ] ], [ 5, [ 3, 2, 5 ] ] ],
	]
	data = np.zeros((len(carrier_choices), num))

	for n, k in enumerate(carrier_choices):
		carriers = [Carrier([stars[j] for j in i[1]], drop_index=i[0]) for i in k[1:]]

		for i in range(num):
			for carrier in carriers:
				carrier.time_to_target -= 1
				if carrier.time_to_target == 0:
					if carrier.index == carrier.drop_index:
						stars[carrier.index].ships += carrier.ships
						carrier.ships = 0
					else:
						carrier.ships += stars[carrier.index].ships
						stars[carrier.index].ships = 0
					carrier.time_to_target = distance(carrier.loop[carrier.index], carrier.loop[(carrier.index+1)%len(carrier.loop)])
					carrier.index = (carrier.index + 1) % len(carrier.loop)
			for star in stars:
				star.ships += 1

			data[n, i] = stars[end_point].ships
	print(data)

	return 0

if __name__ == "__main__":
	main()

