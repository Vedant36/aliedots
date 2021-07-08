#!/usr/bin/env python3

# This script is run at the startup of each interactive python console when
# defined in PYTHONSTARTUP.

import readline
import atexit
import os

if 'XDG_DATA_HOME' in os.environ:
	python_history = os.path.join(os.path.expanduser(os.environ['XDG_DATA_HOME']),
			'python-history')
else:
	python_history = os.path.join(os.path.expanduser('~'), '.python_history')
python_history = os.path.abspath(python_history)
_dir, _ = os.path.split(python_history)
os.makedirs(_dir, exist_ok=True)

try:
	readline.read_history_file(python_history)
	h_len = readline.get_current_history_length()
except FileNotFoundError:
	open(python_history, 'wb').close()
	h_len = 0

if os.path.exists(python_history):
	readline.read_history_file(python_history)
atexit.unregister(readline.write_history_file)
atexit.register(readline.write_history_file, python_history)
