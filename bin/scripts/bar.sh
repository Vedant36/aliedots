#!/bin/sh
# script for dwmblocks
dot=" $(($(ad diff origin/main|wc -l) - $(ad diff origin/main ~/.local/share/zsh/.zsh_history|wc -l)))"
# dot=$(ad diff origin/main | wc -l)
uptime=" $(uptime -p)"
packages=" $(wc -l <$LOG/packages.log)"
bat_state="$(upower -i "$(upower -e | grep BAT)" | grep -E 'state|time to|percentage' | sed 's/.*:\s*\(.*\)/\1/')"
state="" && [ "$(grep discharging <<< $bat_state)" ] && state=""
bat="${state} $(tail -n1 <<< $bat_state) $(tail -n2 <<< $bat_state | head -n1)"
# bat="${state} $(acpi -b | grep -Po '[0-9]+(?=%)')% $(grep -v)"
date=" $(date '+%a %F %H:%M')"
modules=(
	"$dot"
	# "$uptime"
	"$packages"
	"$bat"
	"$date"
)
# echo -e "  ${dot}  ${uptime}  ${packages}  ${bat}  ${date} "
echo -en " "
for i in "${modules[@]}";do
	echo -en " $i "
done
