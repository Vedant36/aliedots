#!/usr/bin/env bash
# Script that outputs the thing to put in dwmblocks(statusbar)
# Rewritten by Vedant too late in the night(202202110249)
# Dependencies: git, upower, mpd and mpc

# lines of changes in my dotfiles
dot=" $(git --git-dir="$HOME"/.local/.git --work-tree="$HOME"/.local diff origin/main | wc -l)"

uptime=" $(uptime | grep -Po 'up \K.*(?=,\s+\d+ user)' | xargs)"

# the packages are updated in a cache everyday using anacrontab
[ -r "$XDG_LOG_HOME"/packages.log ] && \
    packages=" $(wc -l <"$XDG_LOG_HOME"/packages.log 2>/dev/null || printf 0)"

# unreadable code to get battery percentage and time to full/empty
[ -s "$XDG_STATE_HOME"/BAT ] || upower -e | grep BAT > "$XDG_STATE_HOME"/BAT
bat_state="$(upower -i "$(cat "$XDG_STATE_HOME"/BAT)" \
    | grep -E 'state|time to|percentage' \
    | sed 's/.*:\s*\(.*\)/\1/')"
state="▲"; [[ "$bat_state" =~ discharging ]] && state="▼"
bat="${state} $(tail -n2 <<< "$bat_state" | tac | paste -sd ' ')"

volume="$(if pactl get-sink-mute @DEFAULT_SINK@ | grep 'Mute: yes' >/dev/null; then echo "婢"; else echo "墳"; fi) $(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '^\s*Volume:.*/\s*\K.*?(?=\s*/)')"

time=" $(date '+%H:%M')"
date=" $(date '+%a %F')"

music="$(mpc status | grep -q playing && \
    mpc -f " %artist% - %title%" | sed -n 1p)"

sections=(
	"$dot"
	"$uptime"
	"$packages"
	"$music"
	"$bat"
    "$volume"
	"$date"
	"$time"
)

echo -en " "
for i in "${sections[@]}";do
	[ "$i" ] && echo -en "| $i "
done

