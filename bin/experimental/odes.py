#!/usr/bin/env python3
# ordinary differential equation code for testing how fast an approximation converges
import numpy as np

# Physical constants
g = 9.8
L = 2
mu = 10**np.arange(0, -10, -0.1)
t = 100  # the main parameter

THETA_0 = np.pi / 3  # 60 degrees
THETA_DOT_0 = 0  # No initial angular velocity

# Definition of ODE
def get_theta_double_dot(theta, theta_dot, mu):
	return -mu * theta_dot - (g / L) * np.sin(theta)

# Solution to the differential equation
def theta(t, mu):
	# Initialize changing values
	theta = THETA_0
	theta_dot = THETA_DOT_0
	delta_t = 0.01  # Some time step
	for time in np.arange(0, t, delta_t):
		# Take many little time steps of size delta_t
		# until the total time is the function's input
		theta_double_dot = get_theta_double_dot(theta, theta_dot, mu)
		theta += theta_dot * delta_t
		theta_dot += theta_double_dot * delta_t
	return theta

results = [theta(t, i) for i in mu]

import matplotlib.pyplot as plt
plt.plot(results)
plt.show()
