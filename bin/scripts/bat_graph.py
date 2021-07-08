#!/usr/bin/env python
import os
import numpy as np
import matplotlib.pyplot as plt

with open(os.getenv("HOME")+'/.local/var/log/batinfo.log', 'r') as fp:
	data = [[int(j) for j in i.split(':')] for i in fp.read().split('\n')[:-1]]
	x, y = np.asarray(data, dtype=int)[-217:,:].T

	events = list()
	fig, ax = plt.subplots()
	ax.plot(x, y)
	def onclick(event):
		global events
		events.append([event.xdata, event.ydata])
		if len(events)>1:
			events = events[-2:]
			life = 100 * (events[1][0] - events[0][0]) / (events[0][1] - events[1][1])
			print(f"Approx battery life (100->0): {life//3600}hr {life%3600//60}min {life%60}s ({life}s)", flush=True)
	cid = fig.canvas.mpl_connect('button_press_event', onclick)
	plt.show()
	fig.canvas.mpl_disconnect(cid)
