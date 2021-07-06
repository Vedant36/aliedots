#!/bin/sh
# script to alert if battery is above 90% charge to extend battery life
# Used with crontab -e:
# */10 * * * * /home/vedant36/.local/bin/bat_alert.sh
battery_level=$(acpi -b | grep -Po '[0-9]+(?=%)')
charging=$(acpi -b | grep 'Discharging')
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
[ -z "$charging" ] && [ "$battery_level" -ge 90 ] && \
	/usr/bin/notify-send -u critical "The battery is charging above 90%." "Charging: ${battery_level}% "
[ "$charging" ] && [ "$battery_level" -lt 7 ] && \
   /usr/bin/notify-send -u critical "The battery is below 7%." "Discharging: ${battery_level}% "
