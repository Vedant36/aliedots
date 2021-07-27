#!/bin/zsh
# script contains some setup that is needed for my dotfiles like linking some
# files

config_h() {
	for i in $(find $HOME/.local/etc/config.h -type f)
		do ln -f "${i}" "${i/etc\/config.h/opt}"
	done
}

case $1 in
	all)
		config_h
		;;
	config_h)
		config_h
		;;
esac
