# Vedant36's zshenv
# settings {{{1
[ "$ZSHENV_SET" ] && return
export ZSHENV_SET=1
export skip_global_compinit=1
export BROWSER="qutebrowser"
export PM=yay # package manager

export EDITOR="nvim"
export VISUAL="nvim"
export SUDO="rdo"
export LESS='--RAW-CONTROL-CHARS --squeeze-blank-lines --quit-on-intr --quit-if-one-screen --no-init' # --mouse
export PAGER=less
export RANGER_LOAD_DEFAULT_RC=FALSE
export SSH_ASKPASS='pinentry'

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
# XDG and other HOME dirs {{{1
## I should probably loop through every element to check if something is already
## added, but this works for now so no need to increase complexity
[ -z "$PATH_SET" ] &&
    export PATH="$HOME/.local/bin/scripts:$HOME/.local/bin/wrappers:$HOME/.local/bin:$PATH"
export PATH_SET=1
export DATASETS="$HOME/dox/_Other/datasets"
export BIN_HOME="$HOME/.local/bin"
export XDG_CONFIG_HOME="$HOME/.local/etc"
export XDG_CACHE_HOME="$HOME/.local/var/cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/var/lib"
# Non-standard
export XDG_LIB_HOME="$HOME/.local/lib"
export XDG_LOG_HOME="$HOME/.local/var/log"
# ~ Cleanup {{{1
mkdir -p "$XDG_DATA_HOME"/zsh
export HISTFILE=$XDG_DATA_HOME/zsh/.zsh_history
mkdir -p "$XDG_CONFIG_HOME"/java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export LESSHISTFILE=$XDG_DATA_HOME/lesshst
export MAGICK_TEMPORARY_PATH=$XDG_CACHE_HOME/ImageMagick/
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgreprc
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
mkdir -p "$XDG_DATA_HOME/wine/default"
export WINEPREFIX="$XDG_DATA_HOME/wine/default"
