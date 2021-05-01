#!/usr/bin/env python3
# roll a random number n times
# rand range [number of rolls]
from random import randint
from sys import argv

n = 1 if len(argv)<3 else int(argv[2])
for i in range(n):
	print(randint(1, int(argv[1])), end=' ')
print()
