#!/bin/bash
# Description {{{1
# shellcheck disable=SC2164
# Status: Incomplete(do not run, might create black hole)
# Written by Vedant36 hours before going to eat burger at McDonalds
# This script contains the setup required after cloning the repository from
#   github and an unneccesary use of pushd and popd
# This script is meant to be idempotent(can be run multiple times without side
# effects)
# TODO: need to prob add the script to backup to my external harddrive
## Update 0.3 on 2022-02-14:
##   - added wrappers for pushd and popd
##   - improved ce(colored echo)
##   - added check and help subcommand
##   - added error codes
##   - added markers for vim folding
##   - added mpv scripts
##   - added no-root() to avoid running part of script as root
# }}}1

# Here, the prefix directory is assumed to be "$PREFIX"
# Change it according to your needs, or uncomment the next line to
# automatically detect it if running the script from within the repository
PREFIX="$HOME"/.local
# PREFIX="$(git rev-parse --show-toplevel)"

EUNIMPLEMENTED=3  # Feature Unimplemented
ENOTDIR=20  # Directory doesn't exist or can't popd to this directory
ECANCELED=125  # Operation cancelled

pushd(){ command pushd "$1" >/dev/null || exit $ENOTDIR; }
popd(){ command popd >/dev/null || exit $ENOTDIR; }
# idempotent version of git clone $1
ic(){ [ -d "${1##*/}" ] || git clone "$1"; }

# to avoid running parts of script as root {{{1
no-root(){
    [ "$(id -u)" -eq 0 ] && (
        echo err "Don't run this as root"
        exit $ECANCELED
    )
}

# colored echo to seperate status reports from command output {{{1
ce(){
    case "$1" in
        err) echo -e "[\e[1;91mERROR\e[m] $2" 1>&2 ;;
        ok)  echo -e "[\e[1;92mINFO\e[m] $2" 1>&2 ;;
        *)   echo -e "[\e[1;92mINFO\e[m] $1" 1>&2 ;;
    esac
}

# Subcommands' implementation {{{1
case $1 in
    check) # {{{2
        no-root
        ce "Checking repositories in opt..."
        pushd "$PREFIX"/opt
            for i in dmenu dwm slock st surf tabbed;do
                pushd "$i" && git status -su no && popd
            done
        popd
        ;;
    install) # {{{2
        no-root
        pushd "$PREFIX"
        # Important links {{{3
        ce "Linking the script itself"
        ln -sf "$PREFIX"/lib/dotfiles/setup.bash "$PREFIX"/bin/
        ce "Linking zshenv and pam_environment(for environment variables..."
        ln -sf "$PREFIX"/lib/dotfiles/.pam_environment ~
        ln -sf "$PREFIX"/lib/dotfiles/.zshenv ~

        # Crontab {{{3
        ce "Installing crontab..."
        crontab < "$PREFIX"/lib/dotfiles/crontab

        # Zsh {{{3
        ce "Cloning zsh plugins..."
        mkdir -p share/zsh/plugins && \
                pushd share/zsh/plugins
            ic https://github.com/zdharma-continuum/fast-syntax-highlighting
            ic https://github.com/zsh-users/zsh-autosuggestions
        popd

        # Suckless {{{3
        ce "Cloning locally compiled tools..."
        pushd opt
            ic https://git.suckless.org/dwm
            ic https://git.suckless.org/st
            # [ -d patches ] && pushd dwm && patch -Np1 <../patches/dwm/*
            ce "Patch dwm and st manually until patches get version controlled"
            ic https://git.suckless.org/dmenu
            ic https://git.suckless.org/surf
            ic https://git.suckless.org/slock
        popd

        ce "Linking their configs..."
        for file in "$PREFIX"/etc/config.h/*/config.h; do
            ln -sf "${file}" "${file/etc\/config.h/opt}"
        done

        # Qutebrowser {{{3
        #   spellcheck
        /usr/share/qutebrowser/scripts/dictcli.py install en-US
        #   4Chan-X
        ce "Install 4Chan-X greasemonkey script"
        mkdir -p share/qutebrowser/greasemonkey
        curl --output-dir share/qutebrowser/greasemonkey \
            -O 'https://www.4chan-x.net/builds/4chan-X.user.js'

        # Neovim {{{3
        ce "The Neovim plugins will auto-install after opening the editor"
        ce "with a working internet connection(when i finally setup lua)"

        # End }}}3
        popd
        ce "Reboot for the environment variables to take effect"
        ce "Then, you should run $(basename "$0") update"
        ;;

    install-root) # {{{2
        # IDEA: print the script to run to the terminal and let the user run it
        ce "I'm still debating on whether I should make this part"
        ce "must run 'pacman-key --init' as root before first running pacman"
        ce "remove cron.deny if exists"
        ce "hard link/symlink files in $PREFIX/lib/root/ to /"
        ce err "Unimplemented"
        exit $EUNIMPLEMENTED
        ;;

    update) # {{{2
        no-root
        ce "Updating zsh plugins..."
        pushd "$PREFIX"/share/zsh/plugins
            pushd fast-syntax-highlighting && git pull && popd
            pushd zsh-autosuggestions && git pull && popd
        popd

        ce "Updating mpv scripts..."
        mkdir -p "$PREFIX"/etc/mpv/scripts && pushd "$PREFIX"/etc/mpv/scripts
            curl -O 'https://github.com/TheAMM/mpv_thumbnail_script/releases/latest/download/mpv_thumbnail_script_client_osc.lua'
            curl -O 'https://github.com/TheAMM/mpv_thumbnail_script/releases/latest/download/mpv_thumbnail_script_server.lua'
            curl -O 'https://codeberg.org/jouni/mpv_sponsorblock_minimal/raw/branch/master/sponsorblock_minimal.lua'
            curl -O 'https://raw.githubusercontent.com/jonniek/mpv-filenavigator/master/navigator.lua'
        popd

        ce "Manually update locally compiled tools for now"
        ce "Don't forget to update your system using your package manager"
        ;;

    help|*) # {{{2
        cat<<-EOF
Usage $(basename "$0") SUBCOMMAND
SUBCOMMANDS:
    check        : performs pre-defined checks on the repository
    install      : installs the configuration for the first time
    install-root : installs the root config(UNIMPLEMENTED)
    update       : updates the dotfiles(plugins)
EOF
        [ "$1" = help ] || ce err "Unknown subcommand \"$1\""
        ;;
esac # }}}1

