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

idemclone(){
    # idempotent version of git clone $1
    [ -d "${1##*/}" ] || git clone "$1"
}

cecho(){
    # echo with color to seperate status reports from command output
    echo "\033[0;4m$1\007"
}

case $1 in
    install)
        [ $(id -u) -eq 0 ] && (
            echo "\033[0;31mbruh dont run this as root\007"
            return 125
        )

        cecho "Linking zshenv and pam_environment"
        ln -f .pam_environment ~
        ln -f .zshenv ~

        cecho "Cloning zsh plugins..."
        mkdir -p ~/.local/share/zsh/plugins && pushd ~/.local/share/zsh/plugins
        idemclone https://github.com/zdharma-continuum/fast-syntax-highlighting
        idemclone https://github.com/zsh-users/zsh-autosuggestions
        popd

        cecho "Cloning locally compiled tools..."
        pushd ~/.local/opt
        idemclone https://git.suckless.org/dwm
        # [ -d patches ] && pushd dwm && patch -Np1 <../patches/dwm/*
        cecho "Patch dwm manually until patches get version controlled"
        idemclone https://git.suckless.org/dmenu
        idemclone https://git.suckless.org/st
        idemclone https://git.suckless.org/surf
        idemclone https://git.suckless.org/slock
        popd

        cecho "Linking their configs..."
        for i in $(find $HOME/.local/etc/config.h -type f)
            do ln -f "${i}" "${i/etc\/config.h/opt}"
        done

        cecho "Install 4Chan-X greasemonkey script"
        curl --output-directory ~/.local/share/qutebrowser/greasemonkey \
            'https://www.4chan-x.net/builds/4chan-X.user.js'

        cecho "The Neovim plugins will auto-install after opening the editor"
        cecho "with a working internet connection(when i finally setup lua)"

        cecho "Reboot for the environment variables to take effect"
        ;;

    install-root)
        cecho "I'm still debating on whether I should make this part"

        ;;

    update)
        [ $(id -u) -eq 0 ] && (
            echo "\033[0;31mbruh dont run this as root\007"
            return 125
        )

        cecho "Updating zsh plugins..."
        pushd ~/.local/share/zsh/plugins
        pushd fast-syntax-highlighting && git pull && popd
        pushd zsh-autosuggestions && git pull && popd
        popd

        cecho "Don't forget to update your system using your package manager"
        ;;

    *)
        cecho "Usage $0 [install|install-root|update]"
        ;;
esac

