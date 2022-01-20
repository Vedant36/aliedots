#!/bin/zsh
# script contains some setup that is needed for my dotfiles like linking some
# files.
: "
TODO:
root files, user and root crontabs with necessary permissions, patches in dwm
and dmenu
SETUP:
setup root files as a PKGBUILD
zsh,nvim plugins
BACKUP:
lib/private
share/minecraft/{saves,screenshots,modlist}
/var/lib/vnstat/vnstat.db
"

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

        # 4Chan-X
        curl --output-directory "${XDG_DATA_DIR:-$HOME/.local/share}"/qutebrowser/greasemonkey 'https://www.4chan-x.net/builds/4chan-X.user.js'
		;;
	config_h)
		config_h
		;;
    *)
        echo bruh
        ;;
esac

