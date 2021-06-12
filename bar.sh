#!/bin/sh
# script for dwmblocks
while true;do
	dot=$(dot diff | wc -l)
	bat=$(acpi -b | grep -Po '[0-9]+(?=%)')
	date=$(date '+%a %F %H:%M')
	BAR_CONTENT=" ${dot} | ${bat}% | ${date} "
	xsetroot -name "$BAR_CONTENT"
	sleep 1m
done
