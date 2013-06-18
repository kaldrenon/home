# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors

PROMPT="[%{$fg[green]%}%T%{$reset_color%}][%{$fg[blue]%}%n@%m%{$reset_color%}:%2~]$ "
RPROMPT='' # prompt for right side of screen

# Ensure local/bin precedes bin, add Dropbox to PATH
PATH=/usr/local/bin:$PATH:$HOME/Dropbox/bin

# Duh
EDITOR=vim
export EDITOR

# Support colors for excellence
TERM=screen-256color
export TERM

# Used for JRuby optimization for Rails
export JAVA_OPTS="-d32"

###
# TASKWARRIOR ALIASES AND FUNCTIONS
###

alias t="task"
alias ta="task add"
alias td="task +today"
alias tda="task add due:today"

alias tw="task pro:elocal"
alias twa="task add pro:elocal"
alias twbw="task pro:elocal burndown.weekly"
alias twbd="task pro:elocal burndown.daily"

alias th="task pro:home"
alias tha="task add pro:home"

ts(){
  task $1 start
}

usage(){
  du -hc $1 | grep total
}

work(){
  clear
  td pro:elocal
  tw +dragon -today -later
  tw -today -dragon -later
}

home(){
  clear
  td pro:home
  th -today
}

tdm(){
  task $1 mod +today
}

today() {
  clear
  td
}

### OTHER ALIASES 
alias grep="grep --color"
alias c="clear;"
alias kal='ssh kaldrenon@kaldrenon.selfip.net'
alias websh='ssh kaldren1@kaldrenon.com'
alias agi="sudo apt-get install -y"

# gcp
gcp() {
  git add -A
  git commit -m "$*"
  git push
}

# Smart LS
if [[ `hostname` == "fallows" ]] ; then
  LS_COLO_FLAG="-G" ;
else 
  LS_COLO_FLAG="--color" ;
fi
alias ls="ls $LS_COLO_FLAG -a"

# Show the task being run when aliases are involved
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

# Show mode for zsh vi bindings
function zle-line-init zle-keymap-select {
  RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
  RPS2=$RPS1
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin 
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.tmuxinator/scripts/tmuxinator" ]] && source "$HOME/.tmuxinator/scripts/tmuxinator"
