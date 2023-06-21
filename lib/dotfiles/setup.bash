#!/bin/bash
# Description {{{1
# shellcheck disable=SC2164
# Written by Vedant36 hours before going to eat burger at McDonalds
# This script contains the setup required after cloning the repository from
#   github and an unneccesary use of pushd and popd
# This script is meant to be idempotent(can be run multiple times without side
# effects)
# TODOO: add way to update/install updated repos/plugins for specific sections like zsh, qutebrowser, suckless, etc
# TODO: need to prob add the script to backup to my external harddrive
# }}}1

# Here, the prefix directory is assumed to be "$PREFIX"
# Change it according to your needs, or uncomment the next line to
# automatically detect it if running the script from within the repository
PREFIX="$HOME"/.local
# PREFIX="$(git rev-parse --show-toplevel)"

# Check if wget is present, else use curl
DL='curl -OL'
command -v wget >/dev/null || DL='curl -OL'

EUNIMPLEMENTED=3  # Feature Unimplemented
ENOTDIR=20  # Directory doesn't exist or can't popd to this directory
ECANCELED=125  # Operation cancelled

# wrappers suggested by https://github.com/koalaman/shellcheck/wiki/SC2164
pushd(){ command pushd "$1" >/dev/null || exit $ENOTDIR; }
popd(){ command popd >/dev/null || exit $ENOTDIR; }

# idempotent version of git clone {{{1
ic(){
    pull=1
    [ "$1" == "-n" ] && pull='' && shift
    dir="${1##*/}"
    if [ -d "$dir" ]; then
        [ "$pull" ] && pushd "$dir" && git pull && popd
    else
        git clone "$1"
    fi
}

# to avoid running parts of script as root {{{1
no-root(){
    [[ "$(id -u)" -eq 0 ]] && {
        echo err "Don't run this as root"
        exit $ECANCELED
    }
}

# colored echo to seperate status reports from command output {{{1
ce(){
    case "$1" in
        err) echo -e "[\e[1;91mERROR\e[m] $2" 1>&2 ;;
        ok)  echo -e "[\e[1;92mINFO\e[m] $2" 1>&2 ;;
        *)   echo -e "[\e[1;92mINFO\e[m] $1" 1>&2 ;;
    esac
}
# ce-end }}}1
# Subcommands' implementation
case $1 in
    backup) # {{{1
        crontab -l > "$PREFIX"/lib/dotfiles/crontab
        mkdir -p ~/dl/tocopy/zsh/
        cp -f "$PREFIX"/share/zsh/.zsh_history ~/dl/tocopy/zsh/.zsh_history-"$(date +%s)"
        grep -v "^':" "$PREFIX"/share/ranger/bookmarks \
            | sort -t: -k2 -V > "$PREFIX"/lib/dotfiles/bookmarks
        ;;

    check) # {{{1
        no-root
        ce "Checking repositories in opt..."
        pushd "$PREFIX"/opt
            for i in dmenu dwm scroll slock st surf tabbed;do
                pushd "$i" && git status -su no && popd
            done
        popd
        ;;

    install) # {{{1
        # TODO: convert subcommands into a funciton for more modularity
        command "$0" backup
        no-root
        pushd "$PREFIX"
        # Linking {{{2
        ce "Linking the script itself into PATH..."
        ln -sf "$PREFIX"/lib/dotfiles/setup.bash "$PREFIX"/bin/
        ce "Linking zshenv and pam_environment(for environment variables..."
        ln -sf "$PREFIX"/lib/dotfiles/pam_environment ~/.pam_environment

        # Crontab {{{2
        ce "Installing crontab..."
        crontab < "$PREFIX"/lib/dotfiles/crontab

        # Zsh {{{2
        ce "Cloning/Updating zsh plugins..."
        mkdir -p share/zsh/plugins && \
                pushd share/zsh/plugins
            ic https://github.com/zdharma-continuum/fast-syntax-highlighting
            ic https://github.com/zsh-users/zsh-autosuggestions
            mkdir -p fzf-git && pushd fzf-git
                $DL 'https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236/raw/f23942b51333b8e8bcd6816fc063cf54beb8b97f/functions.sh'
                $DL 'https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236/raw/f23942b51333b8e8bcd6816fc063cf54beb8b97f/key-binding.zsh'
            popd
        popd

        # Suckless {{{2
        ce "Cloning locally compiled tools..."
        pushd opt
            ic -n https://git.suckless.org/dwm
            ic -n https://git.suckless.org/st
            ic -n https://git.suckless.org/scroll
            # [ -d patches ] && pushd dwm && patch -Np1 <../patches/dwm/*
            ce "Patch dwm and st manually until patches get version controlled"
            ic -n https://git.suckless.org/dmenu
            ic -n https://git.suckless.org/surf
            ic -n https://git.suckless.org/slock
        popd

        ce "Linking their configs..."
        for file in "$PREFIX"/etc/config.h/*/config.h; do
            ln -sf "${file}" "${file/etc\/config.h/opt}"
        done

        # Qutebrowser {{{2
        #   spellcheck
        ce "Downloading spellcheck for qutebrowser..."
        /usr/share/qutebrowser/scripts/dictcli.py install en-US
        #   4Chan-X
        ce "Downloading greasemonkey scripts..."
        mkdir -p share/qutebrowser/greasemonkey &&
            pushd share/qutebrowser/greasemonkey
            $DL 'https://github.com/Anarios/return-youtube-dislike/raw/main/Extensions/UserScript/Return%20Youtube%20Dislike.user.js'
            $DL 'https://raw.githubusercontent.com/xthexder/wide-github/master/build/wide-github.user.js'
            $DL 'https://greasyfork.org/scripts/438625-arch-wiki-old-skin/code/Arch%20Wiki%20old%20skin.user.js'
            $DL 'https://greasyfork.org/scripts/370246-sci-hub-button/code/Sci-hub%20button.user.js'
            # $DL 'https://greasyfork.org/scripts/394820-mouseover-popup-image-viewer/code/Mouseover%20Popup%20Image%20Viewer.user.js'
            # 4chins
            $DL 'https://www.4chan-x.net/builds/4chan-X.user.js'
            $DL 'https://github.com/g-gundam/4chan-ghostpostmixer/raw/master/4chan-ghostpostmixer.user.js'
        popd

        # MPV {{{2
        ce "Downloading mpv scripts..."
        mkdir -p etc/mpv/scripts && pushd etc/mpv/scripts
            $DL 'https://github.com/TheAMM/mpv_thumbnail_script/releases/latest/download/mpv_thumbnail_script_client_osc.lua'
            $DL 'https://github.com/TheAMM/mpv_thumbnail_script/releases/latest/download/mpv_thumbnail_script_server.lua'
            $DL 'https://codeberg.org/jouni/mpv_sponsorblock_minimal/raw/branch/master/sponsorblock_minimal.lua'
            $DL 'https://raw.githubusercontent.com/jonniek/mpv-filenavigator/master/navigator.lua'
            $DL 'https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua'
        popd

        # Neovim {{{2
        ce "Installing Neovim plugins..."
        nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

        # Ranger {{{2
        ce "Updating ranger plugins..."
        pushd etc/ranger/plugins/ranger_devicons/ && git pull && popd
        cp "$PREFIX"/lib/dotfiles/bookmarks share/ranger

        # Misc {{{2
        ce "Copying youtube-to-mp3 config..."
        mkdir -p etc/MediaHuman
        cp "$PREFIX/lib/dotfiles/YouTube to MP3.conf" etc/MediaHuman/

        ce "Updating Package lists..."
        pacman -Qqen>lib/dotfiles/pkglist.txt
        pacman -Qqem>lib/dotfiles/foreignpkglist.txt

        # End }}}2
        popd
        ce "Manually update locally compiled tools for now"
        ce "Reboot for the environment variables to take effect"
        ce "Don't forget to update your system using your package manager"
        ;;

    install-root) # {{{1
        # IDEA: print the script to run to the terminal and let the user run it
        ce "I'm still debating on whether I should make this part"
        ce "must run 'pacman-key --init' as root before first running pacman"
        ce "remove /etc/cron.deny if exists"
        ce "chown root:root for all files in lib/root"
        ce "hard link/symlink files in $PREFIX/lib/root/ to /"
        ce err "Unimplemented"
        exit $EUNIMPLEMENTED
        ;;

    help|*) # {{{1
        cat<<-EOF
Usage $(basename "$0") SUBCOMMAND
SUBCOMMANDS:
    backup       : execute some backup commands
    check        : performs pre-defined checks on the repository
    install      : does the necessary installation / upgrade(if some things are
                   already installed)
    install-root : installs the root config(UNIMPLEMENTED)
EOF
        [ "$1" = help ] || ce err "Unknown subcommand \"$1\""
        ;;
esac # }}}1
