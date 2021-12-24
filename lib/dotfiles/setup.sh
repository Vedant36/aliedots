#!/bin/zsh
# script contains some setup that is needed for my dotfiles like linking some
# files.
# TODO: root files, user and root crontabs with necessary permissions, 
# minecraft files, zsh plugins
# idea: do root files as a PKGBUILD, will only be useful on arch based

on_setup() {
}

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

