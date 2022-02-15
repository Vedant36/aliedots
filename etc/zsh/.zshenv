# !/usr/bin/env zsh
[[ "$-" != *i* ]] && return # if aint runnin interactively dont do anything
# settings {{{1
export skip_global_compinit=1
export BROWSER="qutebrowser"
export PM=yay # package manager
export QT_QPA_PLATFORMTHEME=qt5ct

export TERMINAL=kitty
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO="doas"
export LESS='--RAW-CONTROL-CHARS --squeeze-blank-lines --quit-on-intr --quit-if-one-screen --no-init' # --mouse
export PAGER="nvim -"
export MANPAGER="nvim +Man\!"
export RANGER_LOAD_DEFAULT_RC=FALSE

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
# XDG and other HOME dirs {{{1
export SCRIPTS="$HOME/.local/bin/scripts"
export PATH="$SCRIPTS:$HOME/.local/bin/wrappers:$HOME/.local/bin:$PATH"
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
export _FASD_DATA="$XDG_DATA_HOME"/fasd
mkdir -p "$XDG_DATA_HOME/wine/default"
export WINEPREFIX="$XDG_DATA_HOME/wine/default"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
# export PYTHONSTARTUP=$XDG_LIB_HOME/python/startup.py
mkdir -p "$XDG_CONFIG_HOME"/ipython
export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgreprc
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
# export __GL_SHADER_DISK_CACHE_PATH=$XDG_CACHE_HOME/nv
# [[ ! -d $XDG_CACHE_HOME/nv ]] && mkdir $XDG_CACHE_HOME/nv
mkdir -pm700 $XDG_DATA_HOME/gnupg
export GNUPGHOME=$XDG_DATA_HOME/gnupg
mkdir -p "$XDG_DATA_HOME"/zsh
export HISTFILE=$XDG_DATA_HOME/zsh/.zsh_history
export LESSHISTFILE=$XDG_DATA_HOME/lesshst
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
# fzf {{{1
export FZF_{DEFAULT,CTRL_T}_COMMAND='find . -path "*/.git" -prune -o -path "*/.cache" -prune -o -print 2>/dev/null | sed 1d'
export FZF_ALT_C_COMMAND='find . -type d -a \( -path "*/.git" -prune -o -path "*/.cache" -prune -o -print \) 2>/dev/null | sed 1d'
# nvim binding doesn't work
export FZF_DEFAULT_OPTS="-m --reverse --tiebreak=begin --info=inline --bind 'ctrl-space:execute(nvim {}),ctrl-y:execute-silent(echo {} | xsel -ib)+abort' 2>/dev/null"
export FZF_CTRL_T_OPTS=" --tiebreak=begin --preview \"bat --color=always --style=numbers {}\""
export FZF_ALT_C_OPTS=" --tiebreak=begin --preview 'ls -Al {}'"
# export FZF_CTRL_R_OPTS=""
# ps ch $$ >> ~/.local/var/log/calls.log
