#!/bin/sh
# script for dwmblocks
# lines of changes in my dotfiles
dot=" $(($(ad diff origin/main|wc -l) - $(ad diff origin/main ~/.local/share/zsh/.zsh_history|wc -l)))"
# dot=$(ad diff origin/main | wc -l)
uptime=" $(uptime -p)"
# retrieve number of packages that can be upgraded that is cached using a
# cronjob(currently disabled)
packages=" $(if [ -s $LOG/packages.log ]; then wc -l <$LOG/packages.log;else printf 0;fi)"
bat_state="$(upower -i "$(upower -e | grep BAT)" | grep -E 'state|time to|percentage' | sed 's/.*:\s*\(.*\)/\1/')"
state="▲" && [ "$(grep discharging <<< $bat_state)" ] && state="▼"
bat="${state} $(tail -n1 <<< $bat_state) $(tail -n2 <<< $bat_state | head -n1)"
# bat="${state} $(acpi -b | grep -Po '[0-9]+(?=%)')% $(grep -v)"
date=" $(date '+%a %F %H:%M')"
music="$(mpc status | grep playing>/dev/null && mpc -f " %artist% - %title%" | sed -n 1p)"

modules=(
	"$dot"
	# "$uptime"
	"$packages"
	"$music"
	"$bat"
	"$date"
)

# echo -e "  ${dot}  ${uptime}  ${packages}  ${bat}  ${date} "
echo -en " "
for i in "${modules[@]}";do
	[ "$i" ] && echo -en "| $i "
done
