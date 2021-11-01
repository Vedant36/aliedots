#!/bin/sh
LOGFILE=$HOME/.local/var/log/batinfo.log
echo "$(date +%s) $(acpi -b | grep -Po '[0-9]+(?=%)')" >> $LOGFILE
# cat $LOGFILE | tail -n100 > $LOGFILE
