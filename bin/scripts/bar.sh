#!/bin/sh
# script for dwmblocks
dot=$(ad diff origin/main | wc -l)
uptime=$(uptime | cut -d: -f1,2)
bat=$(acpi -b | grep -Po '[0-9]+(?=%)')
date=$(date '+%a %F %H:%M')
echo -e "   ${dot}  ${uptime}   ${bat}%   ${date} "
