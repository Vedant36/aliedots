#!/bin/sh
# script contains some setup that is needed for my dotfiles like linking some
# files

config.h() {
	for i in $(find $HOME/.local/etc/config.h -type f)
		do ln -sf ${i} ${i/etc\/config.h/opt}
	done
}

case $1 in
	all)
		config.h
		;;
	config.h)
		config.h
		;;
esac

