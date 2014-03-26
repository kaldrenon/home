# TEMPORARY
prod_dep() {
  gco a198e675b056b9dda7efd2084e4e3721904dd1c9 config/deploy.rb
  cap to_production deploy
  git reset --hard HEAD
}


# Antigen bundles
source ~/antigen.zsh
#
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle brew
antigen bundle knife
antigen bundle web-search
antigen apply

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

alias hl="history -D -n -1"


# Support colors for excellence!
TERM=screen-256color
export TERM

###
# ALIAS: Other aliases
###

# CLI tools
alias grep="grep --color"
alias c="clear;"
alias ag="noglob ag "
alias td="echo \`date +'%m/%d/%Y'\`"
alias wat='man'

# Ubuntu/Debian
alias agi="sudo apt-get install -y"

# PostgreSQL
alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

# Ruby Dev
alias unicrestart="sudo kill -USR2 \`pgrep -f 'unicorn master'\`"
alias irb="pry"
alias cop='clear; rubocop'

# Git(Hub)
alias ga="git add"
alias gaa="git add -A"
alias gcl="git clone"
alias gco="git checkout"
alias gg="noglob git grep "
alias gs="git status"

###
# FUNC: Custom Functions
###

vlm() {
  vim -o db/migrate/`ls db/migrate | tail -$1`
}

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

# more powerful silver-search
agg () {
  echo "-- Files"
  noglob ag -g $*
  echo "\n-- Lines"
  noglob ag $*
  echo ""
}

# Shorthand for a JSON curl request
jcurl() {
  curl -X POST -H 'Content-Type: application/json' $1 --data $2
}

# Reload this file
zz() {
  source ~/.zshrc
}

# Search power
vimag() {
  vim -o `ag -l $1`
}

###
# TMUX: things that specifically benefit tmux usage
###

## CD to given path in all panes
# NOTE: assumes all panes are at a clear zsh prompt; must use absolute dirs or
# have all panes in same path to get the same result
tmcd() {
  for pane in `tmux list-panes -F '#P'`; do
    tmux select-pane -t $pane
    tmux send-keys "cd $1" C-m c C-m
  done
}

# Print all the color names for TMUX highlighting
tmuxcolors() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

###
# MISC: Various things
###

# Smart LS - different flag depending on host
# OSX uses /Users, other hosts use /home
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
    export AWS_RDS_HOME="/Users/andrew/rds_tools";
    export AWS_ACCESS_KEY_ID="AKIAJZAR6QC6Q2L53AVQ";
    export AWS_SECRET_ACCESS_KEY="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";
    export AWS_CREDENTIAL_FILE="$HOME/.ec2/creds-file"
    export AWS_SSH_KEY_ID=elocal_andrew;
    export KNIFE_USER_NAME=asfallows;
    HOST_PATH=/Applications/Postgres93.app/Contents/MacOS/bin:/Users/andrew/elb_tools/bin:/Users/andrew/rds_tools

    # Used for JRuby optimization for Rails
    export JAVA_OPTS="-d32"
    ;;
  *)
    ;;
esac

# Address some issues with home/end, at least on OSX
[[ -z "$terminfo[khome]" ]] || bindkey -M viins "$terminfo[khome]" beginning-of-line &&
                               bindkey -M vicmd "$terminfo[khome]" beginning-of-line
[[ -z "$terminfo[kend]"  ]] || bindkey -M viins "$terminfo[kend]" end-of-line &&
                               bindkey -M vicmd "$terminfo[kend]" end-of-line
[[ -z "$terminfo[kdch1]" ]] || bindkey -M viins "$terminfo[kdch1]" vi-delete-char &&
                               bindkey -M vicmd "$terminfo[kdch1]" vi-delete-char
[[ -z "$terminfo[kpp]"   ]] || bindkey -M viins -s "$terminfo[kpp]" ''
[[ -z "$terminfo[knp]"   ]] || bindkey -M viins -s "$terminfo[knp]" ''

# Use PageUp/PageDown to search history
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

#####
# ELOCAL: Managing elocal servers
#####
elcat() {
  ruby -rjson -ropen-uri -e 'puts JSON.parse(open("http://www.elocal.com/categories.json").read)["categories"].map{|c| "%5d| %s" % [c["id"].to_i, c["name"]]}' | ag "^ +$1\|"
}

elcats() {
  ruby -rjson -ropen-uri -e 'puts JSON.parse(open("http://www.elocal.com/categories.json").read)["categories"].map{|c| "%5d| %s" % [c["id"].to_i, c["name"]]}'
}

githash() {
  ssh $1 "cd /mnt/deploy/$2/current; git rev-parse HEAD";
}

elgrep() {
  for ff in 1 2 3;
  do
    echo "-- Elocal Prod Web $ff --";
    ssh elocal_production_web_$ff "sudo grep --color '$1' /var/log/syslog" | ag $1;
    echo ''
  done
}

elgrephist() {
  for ff in 1 2 3;
  do
    echo "-- Elocal Prod Web $ff --";
    ssh elocal_production_web_$ff "sudo grep --color '$1' /var/log/syslog.1" | ag $1;
    echo ''
  done
}

bdgrep() {
  echo "-- Bearded Dragon Prod --";
  ssh bdprod "sudo grep --color '$1' /var/log/syslog" | ag $1
  echo ''
}

bdgreps() {
  echo "-- Bearded Dragon Stage --";
  ssh bdstage "sudo grep --color '$1' /var/log/syslog" | ag $1
  echo ''
}

# Ensure local/bin precedes bin, add RVM, Dropbox to PATH
PATH=$HOME/.rvm/bin:$HOST_PATH:/usr/local/bin:$PATH:$HOME/Dropbox/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Vim is default editor for all things
EDITOR=`which vim`
export EDITOR

VISUAL=`which vim`
export VISUAL
