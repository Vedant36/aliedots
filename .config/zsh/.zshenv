#!/usr/bin/env zsh
# settings {{{1
export skip_global_compinit=1
export PATH="$HOME/.local/bin:$PATH"
export REPOS="$HOME/dox/{textfiles,CPlus,Python,dotfiles,datasets}"
export BROWSER="qutebrowser"
export PM=yay # package manager
alias dot='git --git-dir=$HOME/dox/aliedots --work-tree=$HOME'

export EDITOR="nvim"
export VISUAL="nvim"
# export LESS='--RAW-CONTROL-CHARS --squeeze-blank-lines --quit-on-intr --quit-if-one-screen --no-init' # --mouse
# export PAGER="nvim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
#     -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
#     -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -"
export PAGER="nvim -"
export MANPAGER="nvim -c 'set ft=man' -"
export RANGER_LOAD_DEFAULT_RC=FALSE

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
# XDG HOME dirs {{{1
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
# ~ Cleanup {{{1
export PYTHONSTARTUP=$HOME/.local/bin/startup.py
# export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgreprc
export GNUPGHOME=$XDG_DATA_HOME/gnupg
[[ ! -d $XDG_DATA_HOME/gnupg ]] && mkdir -m700 $XDG_DATA_HOME/gnupg 
export HISTFILE=$XDG_DATA_HOME/zsh/.zsh_history
export LESSHISTFILE=$XDG_DATA_HOME/lesshst
export __GL_SHADER_DISK_CACHE_PATH=$XDG_CACHE_HOME/nv
[[ ! -d $XDG_CACHE_HOME/nv ]] && mkdir $XDG_CACHE_HOME/nv
# fzf {{{1
export FZF_{DEFAULT,CTRL_T}_COMMAND='find . -path "*/.git" -prune -o -path "*/.cache" -prune -o -print 2>/dev/null | sed 1d'
export FZF_ALT_C_COMMAND='find . -type d -a \( -path "*/.git" -prune -o -path "*/.cache" -prune -o -print \) 2>/dev/null | sed 1d'
export FZF_DEFAULT_OPTS="-m --reverse --tiebreak=begin --info=inline --bind 'ctrl-space:execute(nvim {}),ctrl-y:execute-silent(echo {} | xsel -ib)+abort' 2>/dev/null"
export FZF_CTRL_T_OPTS=" --tiebreak=begin --preview \"batcat --color=always --style=numbers {}\""
export FZF_ALT_C_OPTS=" --tiebreak=begin --preview 'ls -Al {}'"
# export FZF_CTRL_R_OPTS=""
# ps ch $$ >> ~/.local/var/log/calls.log
