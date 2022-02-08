#!/bin/bash
# Version: 0.2
# Status: Incomplete(do not run, might create black hole)
# Written by Vedant36 hours before going to eat burger at McDonalds
# This script contains the setup required after cloning the repository from
#   github and an unneccesary use of pushd and popd
# This script is meant to be idempotent(can be run multiple times without side
# effects)

# IDEA: convert to make?
# Backup: need to prob add the script to backup to my external harddrive
# lib/private
# share/minecraft/{saves,screenshots,modlist}
# /var/lib/vnstat/vnstat.db

# Tags that can be found in comments throughout the scripts and config:
#   `TODO` for procrastinating
#   `IDEA` or `IDEAS` for possible changes
#   `SYSTEM_DEPENDENT` for code that might not work on other systems

# Here, the prefix directory is assumed to be "$PREFIX"
# Change it according to your needs, or uncomment the next line to
# automatically detect it
PREFIX=$(git rev-parse --show-toplevel)

ic(){
    # idempotent version of git clone $1
    [ -d "${1##*/}" ] || git clone "$1"
}

ce(){
    # colored echo to seperate status reports from command output
    echo "\033[0;4m[INFO] $1\007" 1>&2
}

case $1 in
    install)
        [ "$(id -u)" -eq 0 ] && (
            echo "\033[0;31mbruh dont run this as root\007"
            return 125
        )

        ce "Linking zshenv and pam_environment"
        ln -sf .pam_environment ~
        ln -sf .zshenv ~

        ce "Cloning zsh plugins..."
        mkdir -p "$PREFIX"/share/zsh/plugins \
				&& pushd "$PREFIX"/share/zsh/plugins || exit 1
            ic https://github.com/zdharma-continuum/fast-syntax-highlighting
            ic https://github.com/zsh-users/zsh-autosuggestions
        popd || exit 1

        ce "Cloning locally compiled tools..."
        pushd "$PREFIX"/opt || exit 1
            ic https://git.suckless.org/dwm
            # [ -d patches ] && pushd dwm && patch -Np1 <../patches/dwm/*
            ce "Patch dwm manually until patches get version controlled"
            ic https://git.suckless.org/dmenu
            ic https://git.suckless.org/st
            ic https://git.suckless.org/surf
            ic https://git.suckless.org/slock
        popd || exit 1

        ce "Linking their configs..."
        for file in "$PREFIX"/etc/config.h/*/config.h; do
            ln -f "${file}" "${file/etc\/config.h/opt}"
        done

        ce "Installing crontab..."
        crontab < "$PREFIX"/lib/dotfiles/crontab

        ce "Install 4Chan-X greasemonkey script"
        mkdir -p "$PREFIX"/share/qutebrowser/greasemonkey
        curl --output-directory "$PREFIX"/share/qutebrowser/greasemonkey \
            'https://www.4chan-x.net/builds/4chan-X.user.js'

        ce "The Neovim plugins will auto-install after opening the editor"
        ce "with a working internet connection(when i finally setup lua)"

        ce "Reboot for the environment variables to take effect"
        ;;

    install-root)
        ce "I'm still debating on whether I should make this part"
        ce "must run 'pacman-key --init' as root before first running pacman"
        ce "remove cron.deny if exists"
        ce "hard link/symlik files in $PREFIX/lib/root/"
        ;;

    update)
        [ "$(id -u)" -eq 0 ] && (
            echo "\033[0;31mbruh dont run this as root\007"
            return 125
        )

        ce "Updating zsh plugins..."
        pushd "$PREFIX"/share/zsh/plugins || exit 1
            pushd fast-syntax-highlighting && git pull && popd || exit 1
            pushd zsh-autosuggestions && git pull && popd || exit 1
        popd || exit 1 || exit 1

        ce "Manually update locally compiled tools for now"

        ce "Don't forget to update your system using your package manager"
        ;;

    *)
        ce "Usage $0 [install|install-root|update]"
        ;;
esac
# vim: noet
