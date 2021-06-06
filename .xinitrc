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
set r rate 250 200
setxkbmap -option "ctrl:nocaps"
xsetroot -cursor_name left_ptr
type unclutter>/dev/null && unclutter -idle 1 -root -jitter 40

# startup programs
artha &
#feh --no-fehbg --bg-scale "$HOME/dl/pexels-carlos-oliva-3586966.jpg"
#picom -f &
#exec dwm

