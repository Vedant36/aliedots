#!/bin/sh
# Status: Incomplete(do not run, might create black hole)
# Written by Vedant36 hours before going to eat burger at McDonalds
# This script contains the setup required after cloning the repository from
#   github and an unneccesary use of pushd and popd
# This script is meant to be idempotent(can be run multiple times without side
# effects)
: "
TODO:
root files, user and root crontabs with necessary permissions
SETUP:
setup root files as a PKGBUILD
BACKUP:
lib/private
share/minecraft/{saves,screenshots,modlist}
/var/lib/vnstat/vnstat.db
ROOT:
remove cron.deny if exists
install files in etc/root
NOTES:
make fully idempotent
need to prob add the script to backup to my external harddrive
"
ROOT=$(git rev-parse --show-toplevel)
# Here, the root directory is assumed to be ~/.local
# Change it according to your needs

case $1 in
    install)
        [ $(id -u) -eq 0 ] && (
            echo "bruh dont run this as root"
            return 125
        )

        echo "Linking zshenv and pam_environment"
        ln .pam_environment ~
        ln .zshenv ~

        echo "Cloning zsh plugins..."
        mkdir -p ~/.local/share/zsh/plugins && pushd ~/.local/share/zsh/plugins
        git clone https://github.com/zdharma-continuum/fast-syntax-highlighting
        git clone https://github.com/zsh-users/zsh-autosuggestions
        popd

        echo "Cloning locally compiled tools..."
        pushd ~/.local/opt
        git clone https://git.suckless.org/dwm
        [ -d patches ] && pushd dwm && patch -p1 <../patches/dwm/*
        git clone https://git.suckless.org/dmenu
        [ -d patches ] && pushd dmenu && patch -p1 <../patches/dwm/*
        git clone https://git.suckless.org/surf
        popd

        echo "Linking their configs..."
        for i in $(find $HOME/.local/etc/config.h -type f)
            do ln -f "${i}" "${i/etc\/config.h/opt}"
        done

        echo "Install 4Chan-X greasemonkey script"
        curl --output-directory ~/.local/share/qutebrowser/greasemonkey \
            'https://www.4chan-x.net/builds/4chan-X.user.js'

        echo "The Neovim plugins will auto-install after opening the editor"
        echo "with a working internet connection(when i finally setup lua)"
        echo "Reboot for the environment variables to take effect"
        ;;

    install-root)
        echo "I'm still debating on whether I should make this part"

        ;;

    update)
        [ $(id -u) -eq 0 ] && (
            echo "bruh dont run this as root"
            return 125
        )

        echo "Updating zsh plugins..."
        pushd ~/.local/share/zsh/plugins
        pushd fast-syntax-highlighting && git pull && popd
        pushd zsh-autosuggestions && git pull && popd
        popd

        echo "Don't forget to update your system using your package manager"
        ;;

    *)
        echo "Usage $0 [install|install-root|update]"
        ;;
esac

