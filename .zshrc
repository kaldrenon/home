# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/kaldrenon/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT='[%T][%n:%2~]$ '
RPROMPT='' # prompt for right side of screen

PATH=$PATH:/home/kaldrenon/Dropbox/bin
EDITOR=vim
TERM=screen-256color
export TERM

alias enoc="task pro:enoc"
alias home="task pro:home"
alias t="task"
alias ta="task add"
alias grep="grep --color"
alias c="clear;"
alias rh='clear; rem; home'

# gcp

# Smart LS for git repos
alias ls="if [ -e .git ] ; then ls --color -a; else ls --color; fi"

_-accept-line () {
  emulate -L zsh
  local -a WORDS
  WORDS=( ${(z)BUFFER} )
  local -r FIRSTWORD=${WORDS[1]}
  local -r GREEN=$'\e[32m' RESET_COLORS=$'\e[0m'
  [[ "$(whence -w $FIRSTWORD 2>/dev/null)" == "${FIRSTWORD}: alias" ]] &&
    echo -nE $'\n'"${GREEN}Executing $(whence $FIRSTWORD)${RESET_COLORS}"
  zle .accept-line
}
zle -N accept-line _-accept-line

function zle-line-init zle-keymap-select {
  RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
  RPS2=$RPS1
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
