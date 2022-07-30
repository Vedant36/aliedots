#!/bin/sh
# script to alert if battery is above 90% charge to extend battery life
# Used with crontab -e:
# */10 * * * * /home/vedant36/.local/bin/bat_alert.sh
battery_level=$(acpi -b | grep -Po '[0-9]+(?=%)')
charging=$(acpi -b | grep 'Discharging')
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
[ -z "$charging" ] && [ "$battery_level" -ge 90 ] && \
    /usr/bin/notify-send -u critical \
        "Please disconnect AC power" "Battery charging above 90% ($battery_level%)"
[ "$charging" ] && [ "$battery_level" -lt 7 ] && \
   /usr/bin/notify-send -u critical \
        "Please connect AC power" "Battery discharging below 7% ($battery_level%)"
