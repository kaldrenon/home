# Antigen bundles
source ~/antigen.zsh
#
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle emallson/gulp-zsh-completion
antigen bundle olivierverdier/zsh-git-prompt
antigen apply

HISTFILE=~/.histfile   # Location of command history
HISTSIZE=10000         # Number of history entries to keep in memory
SAVEHIST=10000         # Number of history entries to save in HISTFILE
setopt appendhistory   # Append history from all instances to same histfile
setopt autocd          # change to dirs without needing to prepend 'cd '
setopt extendedglob    # expand globs in autocomplete with super smart smartness
unsetopt beep          # Don't beeping beep.
bindkey -v             # Vi-ish bindings (normal and insert modes)

bindkey -M vicmd '?' history-incremental-search-backward  # Search up through recent commands

autoload -U colors && colors  # simplify color codes for use in this RC file

# Prompt: time user|host current-path git-info →
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}%{%GΔ%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}%{…%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[yellow]%}%{%Gδ%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✓%G%}"

PROMPT='%{$fg_bold[green]%}%T%{$reset_color%} %{$fg_bold[blue]%}%n|%m%{$reset_color%} %2~ $(git_super_status)→ '
RPROMPT="" # prompt for right side of screen

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
alias td="echo \`date +'%m/%d/%Y'\`"
alias wat='man'
alias serve='http-server'
alias cdh='cd ~/home'

# Docker and Vagrant
alias b2d='boot2docker start && $(boot2docker shellinit)'
alias vup='vagrant up'
alias vdown='vagrant halt'
alias vkill='vagrant halt && vagrant destroy -f'

# NeoVim
alias nv="nvim"

HOST_OS=`uname`

# Ubuntu/Debian
if [[ $HOST_OS -eq 'Linux' ]]; then
  alias agi="sudo apt-get install -y"
  alias alert="echo"
fi

# Mac OS only
if [[ $HOST_OS -eq 'Darwin' ]]; then
  alias agi="brew install -y"

  # Load Node Version Manager
  HAS_BREW=`which brew > /dev/null; echo $?`
  [[ 1 -eq $HAS_BREW ]] || source $(brew --prefix nvm)/nvm.sh

  # Voices
  alias alert="say -v 'Victoria'"
fi

# PostgreSQL
alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

alias dotfiles="cd ~/home && nvim -c 'autocmd VimEnter * wincmd H' -o ~/Dropbox/docs/vimwiki/index.wiki .vimrc .zshrc .tmux.conf .githelpers .gitconfig"

alias vimp="nvim --startuptime ~/vim_start.log"

######
# Ruby Dev
######
alias rc="clear; bundle exec rails c"
alias unicrestart="sudo kill -USR2 \`pgrep -f 'unicorn master'\`"
alias irb="pry"
alias cop='clear; rubocop'
rdbupdate() {
  bundle install
  rake db:migrate db:test:prepare
  if [ $? -eq 0 ]; then
    ( alert Migration completed )
  else
    ( alert Migration failed )
  fi
}

# Run a single test file
rtest() {
  local cmd="bundle exec ruby -Itest $1"
  clear
  echo "$fg_bold[blue]Executing $cmd$reset_color"
  eval $cmd
  if [ $? -eq 0 ]; then
    ( alert "Tests completed - $(sed 's/[\/_]/ /g' <<< $1)" & )
  else
    ( alert "Tests failed - $(sed 's/[\/_]/ /g' <<< $1)" & )
  fi
}

rtest_all() {
  local cmd="rake test"
  clear
  echo "$fg_bold[blue]Executing $cmd$reset_color"
  eval $cmd
  if [ $? -eq 0 ]; then
    alert "Tests completed - full test suite"
  else
    alert "Tests failed - full test suite"
  fi
}


######
# Git(Hub)
######
alias ga="git add"
alias gaa="git add -A"
alias gcl="git clone"
alias gco="git checkout"
alias gg="noglob git grep "
alias gs="git status"
alias glg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gcodbsql="git checkout HEAD db/structure.sql"

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

gdc() {
  clear
  git diff "$1^" $1
}

grcs() {
  local branch=$(git rev-parse --abbrev-ref HEAD)
  local remote=$1
  if [ -z "$1" ]; then; local remote='master'; fi

  local local_count=$(git log --oneline --decorate=short $branch..origin/$remote | wc -l | tr -d ' ')
  local remote_count=$(git log --oneline --decorate=short origin/$remote..$branch | wc -l | tr -d ' ')
  echo "  $local_count unmerged commits on $branch"
  echo "  $remote_count unmerged commits on origin/master"
  if [ $remote_count != 0 ]; then
    print_color red "\tPULL!";
  elif [ $local_count != 0 ]; then
    print_color green "\tFree to push.";
  else
    print_color yellow "\tNothing to push or pull.";
  fi
}

grcl() {
  local branch=$(git rev-parse --abbrev-ref HEAD)
  echo "\n-- Commits on $branch missing on origin/master --"
  git log -5 --oneline --decorate=short $branch..origin/master
  echo "\n-- Commits on origin/master missing on $branch --"
  git log -5 --oneline --decorate=short origin/master..$branch
  echo
}


######
# XFinity Home Tools
######

alias cdc="cd ~/comcast; clear"
alias cdx="cd ~/comcast/xfinity_home; clear"
alias xpkg="bundle install && npm install"

grd() {
  git review develop
}

gca() {
  clear
  git add -A
  git status
  print -z 'git commit --amend'
}

######
# Utility
######

print_color() {
  echo "$fg_bold[$1]$2$reset_color"
}

vlm() {
  files=""
  for file in $(ls db/migrate | tail -$1); do
    filename=db/migrate/$file
    files="$files $filename"
  done
  nvim -o $(echo $files)
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
  nvim -o `ag -l $1 $2`
}

vimdl() {
  nvim -o `git dlf`
}

vimconf() {
  nvim -o `git diff --name-only --diff-filter=U`
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

powerup() {
  mkdir -p $HOME/.pow

  cp $HOME/home/.powenv .powenv

  POW_APP_PATH=`pwd`
  cd ~/.pow
  rm `basename $POW_APP_PATH` > /dev/null
  ln -s $POW_APP_PATH
  cd - > /dev/null
}

powercycle() {
  powify restart `basename $(pwd)`
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

lt () {
  ltsA "$@" | head
}

function mcd() { mkdir $1 && cd $1; }

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
  git_branch=`git branch 2>/dev/null | grep -e '^*' | sed -E 's/^\* (.+)$/(\1) /'`
  RPS1="${${KEYMAP/vicmd/- N -}/(main|viins)/- I -}"
  RPS2=$RPS1
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


# Add tmuxinator scripts
HAS_TMUXINATOR=`which tmuxinator > /dev/null; echo $?`
[[ 1 -eq $HAS_TMUXINATOR ]] || source ~/.tmuxinator/tmuxinator.zsh

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

# Ensure local/bin precedes bin, add RVM, Dropbox to PATH
PATH=$HOME/.rvm/bin:$HOST_PATH:/usr/local/bin:$PATH:$HOME/Dropbox/bin:/usr/local/share/npm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Vim is default editor for all things
EDITOR=`which vim`
export EDITOR

VISUAL=`which vim`
export VISUAL

start-agent() {
  if ps ax | grep '[s]sh-agent -s' > /dev/null; then
    # Do nothing
  else
    eval `ssh-agent -s`
  fi
}

start-agent

# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


###
# Comcast
###
ak-cache() {
  curl -IXGET -H "Pragma: akamai-x-cache-on, akamai-x-cache-remote-on, akamai-x-check-cacheable, akamai-x-get-cache-key, akamai-x-get-extracted-values, akamai-x-get-nonces, akamai-x-get-ssl-client-session-id, akamai-x-get-true-cache-key, akamai-x-serial-no" $1
}

cdxhw() {
  CWD=`pwd`
  PROJECT_ROOT='/Users/asfallows/comcast/xfinity_home'
  if [[ $CWD != $PROJECT_ROOT ]];
  then
    cd $PROJECT_ROOT
  fi
}

xnvim() {
  cdxhw && nvim
}

vimgulp() {
  cdxhw
  nvim -c 'autocmd VimEnter * wincmd H' -o gulpfile.js lib/tasks/gulp/*.js
  cd -
}

vimlang() {
  cdxhw
  lang=$1
  if [ -z "$1" ]; then; lang='en-US'; fi
  nvim -o app/assets/languages/$lang/*.json
  cd - > /dev/null
}

vimpc() {
  nvim -o `ag -g app/assets/components/$1/ --ignore demo.html --ignore index.html --ignore **/*.jpg,png,svg --ignore test/*`
}
compctl -W app/assets/components -/ vimpc

alias vc="vimpc"

vimpca() {
  nvim -o `ag -g app/assets/components/$1/`
}
compctl -W app/assets/components -/ vimpca

ulimit -n 4096
