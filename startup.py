#!/usr/bin/env python
# script to get around changing the location of ~/.python_history by setting
# this script as the PYTHONSTARTUP variable
import atexit
import os
import readline

if 'PYTHONHISTFILE' in os.environ:
	histfile = os.path.expanduser(os.environ['PYTHONHISTFILE'])
elif 'XDG_DATA_HOME' in os.environ:
	histfile = os.path.join(os.path.expanduser(os.environ['XDG_DATA_HOME']),
			'python', 'history')
else:
	histfile = os.path.join(os.path.expanduser('~'), '.python_history')
histfile = os.path.abspath(histfile)
_dir, _ = os.path.split(histfile)
os.makedirs(_dir, exist_ok=True)

try:
	readline.read_history_file(histfile)
	h_len = readline.get_current_history_length()
except FileNotFoundError:
	open(histfile, 'wb').close()
	h_len = 0

def save(prev_h_len, histfile):
	new_h_len = readline.get_current_history_length()
	readline.set_history_length(1000)
	readline.append_history_file(new_h_len - prev_h_len, histfile)
atexit.register(save, h_len, histfile)
