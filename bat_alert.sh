#!/bin/sh
# script to alert if battery is above 90% charge to extend battery life
# Used with crontab:
# */10 * * * * /home/vedant36/.local/bin/bat_alert.sh
battery_level=`acpi -b | grep -Po '[0-9]+(?=%)'`
on_ac_power && [ $battery_level -ge 90 ] && (export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus; /usr/bin/notify-send "The battery is charging above 90%." "Charging: ${battery_level}% ")
