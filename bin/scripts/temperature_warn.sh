#!/bin/sh
# Script to warn when CPU temperature is too high
# usually happens when I keep the laptop on my bed or lap, giving little space
# for air to leave
# Used with crontab -e:
# */10 * * * * /home/vedant36/.local/bin/bat_alert.sh
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
temp="$(acpi -t | cut -d" " -f4 | cut -d"." -f1)"
if [ "$((temp > 50))" -eq "1" ]; then
    notify-send -u critical "Temperature too high ($temp° C)";
fi

