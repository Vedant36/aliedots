#!/usr/bin/env python3
# program to run a simulation of the game of life
# given the initial state of the board
# and the number of steps to run the simulation
import numpy as np
import matplotlib.pyplot as plt

np.set_printoptions(threshold=np.inf)
board_size = [10, 10]
steps = 1
initial_state = np.random.randint(2, size=board_size)
print(initial_state)
next_state = np.zeros(board_size, dtype=int)
for n in range(steps):
	for i in range(board_size[0]):
		for j in range(board_size[1]):
			if initial_state[i][j] == 1:
				if initial_state[i-1:i+2, j-1:j+2].sum() in [2, 3]:
					next_state[i][j] = 1
				else:
					next_state[i][j] = 0
			if initial_state[i][j] == 0:
				if initial_state[i-1:i+2, j-1:j+2].sum() == 3:
					next_state[i][j] = 1
				else:
					next_state[i][j] = 0
	initial_state = next_state.copy()
print(next_state)

