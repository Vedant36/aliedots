#!/bin/sh
echo "$(date +%s):$(acpi -b | grep -Po '[0-9]+(?=%)')" >> ~/.local/batinfo.log
