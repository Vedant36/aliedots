#!/usr/bin/env sh
# Wrapper for passing pdfs from qutebrowser to tsp(task-spooler)
for i in "$@"; do
    tsp -L "zathura" sh -c 'curl "$i" -o /tmp/temp && zathura /tmp/temp'
done
