# Vedant36's .zshrc
# shellcheck disable=SC1091,SC2148
#zmodload zsh/zprof
# run-help {{{1
unalias run-help
autoload run-help
# tab-complete {{{1
export ENABLE_CORRECTION="true"
export CASE_SENSITIVE="false"
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
_comp_options+=(globdots)
# next 13 lines' source: https://htr3n.github.io/2018/07/faster-zsh/
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit -u
else
	compinit -C
fi
# Execute code in the background to not affect the current session
{
  # Compile zcompdump, if modified, to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!
autoload -U bashcompinit && bashcompinit # support bash-completions
# auto escape urls
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
# # vi mode {{{1
# bindkey -v
# export KEYTIMEOUT=1
# # Use vim keys in tab complete menu: {{{2
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

# # Change cursor shape for different vi modes. {{{2
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.

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
bindkey -s "^Z" "^A^Kfg^M"
bindkey -s "^[#" "^[[H ^M" # insert a space at the start and execute it
autoload edit-command-line; zle -N edit-command-line
bindkey '^X^E' edit-command-line
# readline keybinds
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^[f' forward-word
bindkey '^[b' backward-word
bindkey "^[d" kill-word
bindkey "^_" undo
# # https://unix.stackexchange.com/questions/25765/pasting-from-clipboard-to-vi-enabled-zsh-or-bash-shell
# vi-append-x-selection () { RBUFFER="$(xsel -o -p </dev/null)$RBUFFER"; }
# zle -N vi-append-x-selection
# bindkey -a '^X' vi-append-x-selection
# vi-yank-x-selection () { print -rn -- "$CUTBUFFER" | xsel -i -p; }
# zle -N vi-yank-x-selection
# bindkey -a '^Y' vi-yank-x-selection

# https://wiki.archlinux.org/title/Zsh#Clear_the_backbuffer_using_a_key_binding
function clear-screen-and-scrollback() {
    echoti civis >"$TTY"
    printf '%b' '\e[H\e[2J\e[3J' >"$TTY"
    zle .reset-prompt
    zle -R
    # printf '%b' '\e[3J' >"$TTY"
    echoti cnorm >"$TTY"
}

zle -N clear-screen-and-scrollback
bindkey '^X^L' clear-screen-and-scrollback

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
export FZF_DEFAULT_COMMAND="fd -H -E '\.git/'"
export  FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export   FZF_ALT_C_COMMAND='fd -H -I --type d -E "\.git/"'
export FZF_DEFAULT_OPTS="--height=20 -m --reverse --info=inline --tiebreak=index"
export  FZF_CTRL_T_OPTS="--tiebreak=begin --preview 'preview {}'"
export   FZF_ALT_C_OPTS="--tiebreak=begin --preview 'preview {}'"
export  FZF_CTRL_R_OPTS="--tiebreak=index"
. /usr/share/doc/find-the-command/ftc.zsh quiet
. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh
export ZSH_PLUGINS="$XDG_DATA_HOME"/zsh/plugins
# Source: https://github.com/zsh-users/zsh-autosuggestions
. "$ZSH_PLUGINS"/zsh-autosuggestions/zsh-autosuggestions.zsh
# Source: https://github.com/zdharma/fast-syntax-highlighting
. "$ZSH_PLUGINS"/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null # colors commands and hex color codes
# Source: https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
#. "$ZSH_PLUGINS"/fzf-git/functions.sh
#bindkey -r '^G'      # remove default ^G bind so fzf-git can use it
#. "$ZSH_PLUGINS"/fzf-git/key-binding.zsh
# load personal scripts last to avoid conflicts with other plugins
. "${ZDOTDIR:-~}"/.zshaliases
. "${ZDOTDIR:-~}"/.zshfunctions
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
# TODO: custom git info script(put on rprompt)
preexec() {
  start_time=$(date +%s)
  echo -ne '\e[5 q'
}

precmd() {
  if [ $start_time ]; then
    end_time=$(date +%s)
    diff=$((end_time-start_time))
    time="$(date -u -d @"$diff" +'%-Mm%-Ss')"
    unset start_time end_time diff
  fi
  export RPROMPT="%B%(?..%F{red}[%?] %f)%F{cyan}${time}%f%b"
  unset time
}
#echo -e "\033[0;32m$(fortune -a | sed 's/^/\t/')\033[0m"
# export PROMPT=" %F{magenta}%~%f%F{blue}>%f "
export PROMPT='%B[%n@%M %F{blue}%~%f]$%b '
# export PROMPT=' %B%F{181}%~ $%f%b '

# to print {{{1
lsmod | grep uvcvideo
echo -n # to avoid getting the error return value
