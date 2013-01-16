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

PROMPT='[%T][%n@%m:%2~]$ '
RPROMPT='' # prompt for right side of screen

PATH=$PATH:$HOME/Dropbox/bin
EDITOR=vim
TERM=screen-256color
export TERM

###
# TASKWARRIOR ALIASES AND FUNCTIONS
###
alias enoc="task pro:enoc"
alias home="task pro:home"
alias rit="task pro:rit"
alias ivcf="task pro:rit.ivcf"
alias iva="task add pro:rit.ivcf"

# Temporary aliases for Fall Quarter
alias rt="task pro:rit +rt"
alias rta="task add pro:rit +rt"
alias mp="task pro:rit +mp"
alias mpa="task add pro:rit +mp"
alias sp="task pro:rit +sp"
alias spa="task add pro:rit +sp"
alias os="task pro:rit +os"
alias osa="task add pro:rit +os"
winter() {
  clear
  rt
  mp
  sp
  os
  rit -rt -mp -sp -os
  ivcf
}

alias t="task"
alias ta="task add"
alias td="task due:today"
alias tda="task add due:today"
today() {
  clear
  td
}

### OTHER ALIASES 
alias grep="grep --color"
alias c="clear;"
alias rh='clear; rem; home'
alias kal='ssh kaldrenon@kaldrenon.selfip.net'
alias websh='ssh kaldren1@kaldrenon.com'
alias cdrit="cd ~/Dropbox/rit2012/"
alias agi="sudo apt-get install -y"
# gcp
gcp() {
  git add *
  git commit -m "$*"
  git push
}

# Edit a Google Doc in vim
gde() {
  google docs edit --title "$*" --editor vim
}

# Smart LS for git repos
if [[ `hostname` == "afallows" ]] ; then
  LS_COLO_FLAG="-G" ;
else 
  LS_COLO_FLAG="--color" ;
fi
alias ls="ls $LS_COLO_FLAG -a"

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
