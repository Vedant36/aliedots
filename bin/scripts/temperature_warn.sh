#!/usr/bin/env sh
temp="$(acpi -t | cut -d" " -f4 | cut -d"." -f1)"
if [ "$((temp > 30))" -eq "1" ]; then
    notify-send -u critical "Temperature too high ($temp° C)";
fi

