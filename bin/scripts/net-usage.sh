#!/bin/sh
curwifi="$(nmcli dev wifi list | grep '^\*' | awk '{print $3}')"
usage="$(vnstat -i wlo1 -d 1 --oneline | cut -d";" -f6 | cut -d" " -f1)"

[ "$curwifi" = "kwata" ] || exit

if [ "$(echo "1.9 < $usage" | bc -l)" = "1" ]; then
    notify-send -u critical "kwata data alert" "used up more than 1.9 ($usage)"
elif [ "$(echo "1.5 < $usage && $usage < 1.6" | bc -l)" = "1" ]; then
    notify-send -u critical "kwata data alert" "used up more than 1.5 ($usage)"
elif [ "$(echo "1 < $usage && $usage < 1.1" | bc -l)" = "1" ]; then
    notify-send -u critical "kwata data alert" "used up more than 1 ($usage)"
fi

echo $curwifi : $usage
