# Vedant36's .zshrc
[[ "$-" != *i* ]] && return # if aint runnin interactively dont do anything
# if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
# 	# exec 'startx "$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1 2>&1 | tee ~/.local/var/log/x.log'
# 	exec startx "$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1
# fi
# # timing code to be used with sort_timings.zsh {{{1
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '
# logfile=$(mktemp /tmp/zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile
# setopt XTRACE
# tab-complete {{{1
export ENABLE_CORRECTION="true"
export CASE_SENSITIVE="false"
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit -u
_comp_options+=(globdots)
autoload -U bashcompinit && bashcompinit # support bash-completions
# vi mode {{{1
bindkey -v
export KEYTIMEOUT=1
# Use vim keys in tab complete menu: {{{2
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes. {{{2
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
# Edit line in vim with ctrl-e: {{{2
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# keybinds {{{1
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[7~"   beginning-of-line
bindkey "^[[8~"   end-of-line
bindkey '^K' kill-line
bindkey '^N' down-line-or-search
bindkey '^P' up-line-or-search
bindkey '^[[1~' beginning-of-line
bindkey '^[[3~' delete-char # why the ack cant terminals interpret what a delete is
bindkey '^[[4~' end-of-line
bindkey '^[[F' end-of-line
bindkey '^[[H' beginning-of-line
# bindkey -s "^A" ""
bindkey -s "^Z" "^Ufg^M"
bindkey -s "^[#" " ^[[H: ^M"
# readline keybinds
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^[f' forward-word
bindkey '^[b' backward-word
# https://unix.stackexchange.com/questions/25765/pasting-from-clipboard-to-vi-enabled-zsh-or-bash-shell
vi-append-x-selection () { RBUFFER=$(xsel -o -p </dev/null)$RBUFFER; }
zle -N vi-append-x-selection
bindkey -a '^X' vi-append-x-selection
vi-yank-x-selection () { print -rn -- $CUTBUFFER | xsel -i -p; }
zle -N vi-yank-x-selection
bindkey -a '^Y' vi-yank-x-selection

# history settings {{{1
export HISTSIZE=100000      # Nearly infinite history; essential to building a cli 'library' to use with fzf/etc
export SAVEHIST=100000
setopt share_history        # share it across sessions
setopt extended_history     # add timestamps to history
setopt hist_ignore_all_dups # don't record dupes in history
setopt hist_ignore_space    # remove command line from history list when first character on the line is a space
setopt hist_reduce_blanks   # remove superflous blanks
setopt hist_no_store

# sourcings(7) fastest to slowest {{{1
. ${ZDOTDIR-~}/.zshaliases
. ${ZDOTDIR-~}/.zshfunctions
. /usr/share/doc/find-the-command/ftc.zsh quiet
. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh
export ZSH_PLUGINS=$XDG_DATA_HOME/zsh/plugins
# url: https://github.com/zsh-users/zsh-autosuggestions
. $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
# url: https://github.com/zdharma/fast-syntax-highlighting
. $ZSH_PLUGINS/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null # colors commands and hex color codes
# setopts {{{1
autoload colors && colors
setopt auto_cd              # type bare dir name and cd to it e.g. `$ /`
setopt complete_in_word     # don't move cursor to end of line on completion
setopt interactive_comments # allow comments even in interactive shells.
unsetopt beep               # don't bloody beep
unsetopt bg_nice            # don't re-nice bg procs to lower priority
unsetopt correct            # don't autocorrect spelling for args
unsetopt correct_all        # don't autocorrect spelling for args
# unsetopt flow_control       # disable ^S/^Q flow control
unsetopt hup                # don't send the HUP signal to running jobs when the shell exits.
unsetopt list_beep          # don't beep on ambiguous completions
unsetopt local_options      # allow funcs to have their own setopts (i.e. don't change globally)
unsetopt local_traps        # allow funcs to have their own signal trap opts (i.e. don't change globally)
typeset -U PATH             # remove duplicate paths

# prompt {{{1
# Todo: custom git info script(put on rprompt)
# errcode="%(?..%K{red}%F{black} %? %f%k%F{red}%K{magenta}%f)"
# dir="%K{blue} %F{black}%(4~|…/%3~|%~) %f%k%F{blue}%f "
preexec() {
  ini=$(($(date +%s%0N)/1000000))
  echo -ne '\e[5 q'
}

precmd() {
  # print -n "\e]0;$(print -P $HOST: zsh '(%~)')\a"
  if [ $ini ]; then
    now=$(($(date +%s%0N)/1000000))
    # total="%K{magenta} %F{black}$(($now-$ini))ms %k%F{magenta}%K{blue}%f"
    total=$(($now-$ini))"ms"
    unset ini now
  else
  fi
  # export PROMPT="${errcode}${total}${dir}"
  export RPROMPT="%(?..%F{red}[%?]%f) %F{cyan}${total}%f"
  # export RPROMPT="%(?..%F{red}[%?]%f)%F{cyan}"$total"%f"
  # export RPROMPT="%(?..%F{red}[%?]%f) %F{magenta}%(4~|…/%3~|%~)%f %F{cyan}"$total"%f"
}
# [[ $SHLVL -gt 3 ]] && shlvl=$(printf "%.s*" {4..$SHLVL}) # shows the recursion level of the shell
export PROMPT=" %F{green}$shlvl%f%F{magenta}%~%f%F{blue}>%f "
# echo -e "\033[0;32m$(fortune -a | sed 's/^/\t/')\033[0m"

# # from :2,7 {{{1
# unsetopt XTRACE
# exec 2>&3 3>&-
# }}}

