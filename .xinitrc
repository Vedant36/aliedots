#!/bin/sh

# builtin default config
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
# merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"
# start some nice programs
[ -d /etc/X11/xinit/xinitrc.d ] && for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
	[ -x "$f" ] && . "$f"
done
unset f

# custom config
# basic stuff
xset r rate 200 200
xset m 4 0
setxkbmap -option "ctrl:nocaps"
xsetroot -cursor_name left_ptr
# type unclutter>/dev/null && unclutter -idle 1 -root -jitter 40

# startup programs
#artha &
feh --no-fehbg --bg-scale "$HOME/pix/ddwstdk-7fba4c5a-6ba8-47c0-a5c6-ba0cc2cd0e75.jpg"
picom -f &
while true;do
	xsetroot -name "$(acpi -b | grep -Po '[0-9]+(?=%)')% | $(date '+%a %F %H:%M')"
	sleep 1m
done &
exec dwm

