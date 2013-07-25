# Limes configured by zsh-newuser-install
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

bindkey -M vicmd '?' history-incremental-search-backward

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
# TW: Taskwarrior aliases and functions
###

alias t="task"
alias ta="task add"
alias td="task +today"

alias tw="task pro:elocal"
alias twa="task add pro:elocal"
alias twbw="task pro:elocal burndown.weekly"
alias twbd="task pro:elocal burndown.daily"
alias tda="task add pro:elocal +dragon"
alias tdat="task add pro:elocal +dragon +today"

alias th="task pro:home"
alias tha="task add pro:home"
alias thbw="task pro:home burndown.weekly"
alias thbd="task pro:home burndown.daily"

alias tb="task pro:buy"
alias buy="task add pro:buy"

bought(){
  task $1 do
}

shop(){
  clear
  task pro:buy
}

ts(){
  task $1 start
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

### Other aliases 
Alias grep="grep --color"
alias c="clear;"
alias kal='ssh kaldrenon@kaldrenon.selfip.net'
alias websh='ssh kaldren1@kaldrenon.com'
alias agi="sudo apt-get install -y"
alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias irb="pry"

alias gs="git status"
alias ga="git add"
alias gaa="git add -A"

###
# FUNC: Custom Functions
###
# git add, commit, push
gcp() {
  git add -A
  git commit -m "$*"
  git push
}
# git add, status, commit
gcs() {
  git add -A
  git status
  print -z 'git commit -m "'
}

usage(){
  du -hc $1 | grep total
}

zz() {
  source ~/.zshrc
}

###
# MISC: Various things
###

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


# Configure AWS environment variables
case $HOST in
  fallows)
    export JAVA_HOME="$(/usr/libexec/java_home)";
    export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)";
    export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)";
    export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars";

    export AWS_ELB_HOME="/Users/andrew/elb_tools";
    export AWS_ACCESS_KEY_ID="AKIAJZAR6QC6Q2L53AVQ";
    export AWS_SECRET_ACCESS_KEY="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";
    export AWS_SSH_KEY_ID=elocal_andrew;
    export KNIFE_USER_NAME=asfallows;
    export PATH=$PATH:/Users/andrew/elb_tools/bin
    ;;
  *)
    ;;
esac

# Hopefully address some issues with home/end
[[ -z "$terminfo[khome]" ]] || bindkey -M viins "$terminfo[khome]" beginning-of-line &&
                               bindkey -M vicmd "$terminfo[khome]" beginning-of-line
[[ -z "$terminfo[kend]"  ]] || bindkey -M viins "$terminfo[kend]" end-of-line &&
                               bindkey -M vicmd "$terminfo[kend]" end-of-line
[[ -z "$terminfo[kdch1]" ]] || bindkey -M viins "$terminfo[kdch1]" vi-delete-char &&
                               bindkey -M vicmd "$terminfo[kdch1]" vi-delete-char
[[ -z "$terminfo[kpp]"   ]] || bindkey -M viins -s "$terminfo[kpp]" ''
[[ -z "$terminfo[knp]"   ]] || bindkey -M viins -s "$terminfo[knp]" ''
