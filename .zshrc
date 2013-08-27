HISTFILE=~/.histfile   # Location of command history
HISTSIZE=10000         # Number of history entries to keep in memory
SAVEHIST=10000         # Number of history entries to save in HISTFILE
setopt appendhistory   # Append history from all instances to same histfile
setopt autocd          # change to dirs without needing to prepend 'cd '
setopt extendedglob    # expand globs in autocomplete with super smart smartness
unsetopt beep          # Don't beeping beep.
bindkey -v             # Vi-ish bindings (normal and insert modes)

# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey -M vicmd '?' history-incremental-search-backward  # Search up through recent commands

autoload -U colors && colors  # simplify color codes for use in this RC file

# Prompt: [time (green)][user@host (blue): current path (depth 2)]$
PROMPT="[%{$fg[green]%}%T%{$reset_color%}][%{$fg[blue]%}%n@%m%{$reset_color%}:%2~]$ "
RPROMPT='' # prompt for right side of screen

# Ensure local/bin precedes bin, add Dropbox to PATH
PATH=/usr/local/bin:$PATH:$HOME/Dropbox/bin

# Vim is default editor for all things
EDITOR=vim
export EDITOR

# Support colors for excellence!
TERM=screen-256color
export TERM

###
# TW: Taskwarrior aliases and functions
###

alias t="task"
alias ta="task add"

alias tw="task pro:elocal"
alias twa="task add pro:elocal"
alias twbw="task pro:elocal burndown.weekly"
alias twbd="task pro:elocal burndown.daily"
alias tda="task add pro:elocal +dragon"
alias tdat="task add pro:elocal +dragon due:today"

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

# Show a summary of what's on deck
work(){
  clear
  task pro:elocal due.before:tomorrow
  tw +dragon due.after:tomorrow
  tw +dragon due.none:
}

home(){
  clear
  task pro:home due.before:tomorrow
  th due.after:tomorrow
  th due.none:
}

# mark a task as 'do it today'
tdm(){
  echo "task $1 mod due:`date +'%m/%d/%Y'`"
  task $1 mod due:`date +'%m/%d/%Y'`
}

tdr() {
  task $1 mod due:
}

### Other aliases 
alias grep="grep --color"
alias c="clear;"
alias kal='ssh andrew@kaldrenon.selfip.net'
alias websh='ssh kaldreno@kaldrenon.com'
alias agi="sudo apt-get install -y"
alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias unicrestart="sudo kill -USR2 \`pgrep -f 'unicorn master'\`"
alias irb="pry"
alias cop='clear; rubocop'
alias td="echo \`date +'%m/%d/%Y'\`"

alias gs="git status"
alias ga="git add"
alias gaa="git add -A"

###
# FUNC: Custom Functions
###

appg() {
  case $HOST in
    fallows.elocal)
      ;;
    fallows)
      echo "Executing 'brew install $1"
      brew install $1
      ;;
    *)
      echo "Executing 'sudo apt-get install $1"
      sudo apt-get install $1
      ;;
  esac
}

# git add, commit, push
gcp() {
  git add -A
  git commit -m "$*"
  git push
}

# git add, status, prepare to commit
gcs() {
  clear
  git add -A
  git status
  print -z 'git commit -m "'
}

# Quick alias to get disk usage of a dir
usage(){
  du -hc $1 | grep total
}

# Reload this file
zz() {
  source ~/.zshrc
}

# CD to given path in all panes 
# NOTE: currently assumes all panes are at a clear zsh prompt; must use absolute dirs or 
# have all panes in same path to get the same result
tmcd() {
  for pane in `tmux list-panes -F '#P'`; do
    tmux select-pane -t $pane
    tmux send-keys "cd $1" C-m c C-m
  done
}

###
# MISC: Various things
###

# Smart LS
if [[ -e "/Users/`whoami`" ]] ; then
  LS_COLO_FLAG="-G" ;
else 
  LS_COLO_FLAG="--color" ;
fi
alias ls="ls $LS_COLO_FLAG -A"
alias ll="ls $LS_COLO_FLAG -A -l"
alias la="=ls $LS_COLO_FLAG"

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

# Show mode in right prompt for zsh vi bindings
function zle-line-init zle-keymap-select {
  RPS1="${${KEYMAP/vicmd/- N -}/(main|viins)/- I -}"
  RPS2=$RPS1
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin 
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Add tmuxinator scripts
[[ -s "$HOME/.tmuxinator/scripts/tmuxinator" ]] && source "$HOME/.tmuxinator/scripts/tmuxinator"


# Configure AWS environment variables
case $HOST in
  fallows.elocal)
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

    # Used for JRuby optimization for Rails
    export JAVA_OPTS="-d32"
    ;;
  *)
    ;;
esac

lpsql() {
  sudo su - postgres -c "export PATH='/Library/PostgreSQL/9.2/bin:$PATH'; psql"
}


# Hopefully address some issues with home/end
[[ -z "$terminfo[khome]" ]] || bindkey -M viins "$terminfo[khome]" beginning-of-line &&
                               bindkey -M vicmd "$terminfo[khome]" beginning-of-line
[[ -z "$terminfo[kend]"  ]] || bindkey -M viins "$terminfo[kend]" end-of-line &&
                               bindkey -M vicmd "$terminfo[kend]" end-of-line
[[ -z "$terminfo[kdch1]" ]] || bindkey -M viins "$terminfo[kdch1]" vi-delete-char &&
                               bindkey -M vicmd "$terminfo[kdch1]" vi-delete-char
[[ -z "$terminfo[kpp]"   ]] || bindkey -M viins -s "$terminfo[kpp]" ''
[[ -z "$terminfo[knp]"   ]] || bindkey -M viins -s "$terminfo[knp]" ''
