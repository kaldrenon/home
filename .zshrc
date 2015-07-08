# Antigen bundles
source ~/antigen.zsh
#
antigen bundle emallson/gulp-zsh-completion
antigen bundle olivierverdier/zsh-git-prompt
antigen bundle zsh-users/zsh-syntax-highlighting
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

bindkey "Control-k" up-line-or-history-beginning-search-backward
bindkey "Control-j" down-line-or-history-beginning-search-backward

autoload -U colors && colors  # simplify color codes for use in this RC file

# Prompt: time user|host current-path git-info →
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}%{%GΔ%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}%{…%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[yellow]%}%{%Gδ%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✓%G%}"

PROMPT='%{$fg_bold[green]%}%T%{$reset_color%} %{$fg_bold[blue]%}%n|%m%{$reset_color%} %2~ $(git_super_status)→ '
RPROMPT="" # prompt for right side of screen


# Support colors for excellence!
TERM=screen-256color
export TERM

infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > ~/$TERM.ti
tic ~/$TERM.ti

###
# ALIAS: Other aliases
###

# CLI tools
alias grep="grep --color"
alias c="clear;"
alias td="echo \`date +'%m/%d/%Y'\`"

alias wat='man'
alias serve='http-server'

alias drop='cd ~/Dropbox/'
alias code='cd ~/Dropbox/code'
alias cdh='cd ~/home'

alias hl="history -D -n -1"

# Docker and Vagrant
alias b2d='boot2docker start && $(boot2docker shellinit)'
alias vup='vagrant up'
alias vdown='vagrant halt'
alias vkill='vagrant halt && vagrant destroy -f'

alias pax="ps ax | ag"

# NeoVim

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

####
# Vim and NeoVim
####

HAS_NVIM=`which nvim`
if [ ! -z "$HAS_NVIM" ]; then
  VIM_BIN="nvim"
else
  VIM_BIN="vim"
fi

alias v="${VIM_BIN}"
alias nv="${VIM_BIN}"

alias dotfiles="cd ~/home && ${VIM_BIN} -c 'autocmd VimEnter * wincmd H' -o ~/Dropbox/docs/vimwiki/index.wiki .vimrc .zshrc .tmux.conf .githelpers .gitconfig"

alias vimp="${VIM_BIN} --startuptime ~/vim_start.log"

vlm() {
  files=""
  for file in $(ls db/migrate | tail -$1); do
    filename=db/migrate/$file
    files="$files $filename"
  done
  ${VIM_BIN} -o $(echo $files)
}

# Search power
vimag() {
  ${VIM_BIN} -o `ag -l $1 $2`
}

# Open last commit's files
vimdl() {
  ${VIM_BIN} -o `git dlf`
}
alias vl="vimdl"

# Open files in merge conflict state
vimconf() {
  ${VIM_BIN} -o `git diff --name-only --diff-filter=U`
}

# Open vim in xhome project
xvim() {
  cdxhw && ${VIM_BIN}
}

# Open vim with gulp js files arranged
vimgulp() {
  cdxhw
  ${VIM_BIN} -c 'autocmd VimEnter * wincmd H' -o gulpfile.js lib/tasks/gulp/*.js
  cd -
}

vgulp() {
  cdxhw
  ${VIM_BIN} -O gulpfile.js lib/tasks/gulp/$1
}
compctl -W lib/tasks/gulp -f vgulp
alias vg="vgulp"

vimlang() {
  cdxhw
  lang=$1
  if [ -z "$1" ]; then; lang='en-US'; fi
  ${VIM_BIN} -o app/assets/languages/$lang/*.json
  cd - > /dev/null
}

vimpc() {
  ${VIM_BIN} -o `ag -g app/assets/components/$1/ --ignore demo.html --ignore index.html --ignore **/*.jpg,png,svg,mp3 --ignore test/*`
}
compctl -W app/assets/components -/ vimpc

alias vc="vimpc"

vimpca() {
  ${VIM_BIN} -o `ag -g app/assets/components/$1/`
}
compctl -W app/assets/components -/ vimpca

vimdf() {
  ${VIM_BIN} -o `git diff --name-only` `git diff --cached --name-only`
}

######
# Ruby Dev
######
alias rc="clear; bundle exec rails c"
alias bx="bundle exec"
alias irb="pry"
alias cop='clear; rubocop'

# Run a single test file
rtest() {
  if [[ $1 =~ ^spec/ ]]; then
    local cmd="bundle exec rspec $1"
  else
    local cmd="bundle exec ruby -Itest $1"
  fi

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
# JS Dev
######

mtest() {
  local cmd="mocha $1"
  clear
  echo "$fg_bold[blue]Executing $cmd$reset_color"
  eval $cmd
  if [ $? -eq 0 ]; then
    ( alert "Tests completed - $(sed 's/[\/_]/ /g' <<< $1)" & )
  else
    ( alert "Tests failed - $(sed 's/[\/_]/ /g' <<< $1)" & )
  fi
}


######
# Git(Hub)
######
alias ga="git add"
alias gaa="git add -A"
alias gcl="git clone"
alias gco="git checkout"
alias gs="git status"

# git add, status, prepare to commit
gcs() {
  clear
  git add -A
  git status
  print -z 'git commit -m "'
}

######
# XFinity Home Tools
######

alias cdc="cd ~/comcast; clear"
alias cdx="cd ~/comcast/xfinity_home; clear"

grd() {
  git review develop
}

######
# Utility
######

# Quick alias to get disk usage of a dir
usage(){
  du -hc $1 | grep total
}

# more powerful silver-search
agg() {
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

###
# TMUX: things that specifically benefit tmux usage
###

alias tma="tmux attach -t"

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
alias ll="ls $LS_COLO_FLAG -A -lh"
alias lh="ls $LS_COLO_FLAG -A -lh"
alias la="=ls $LS_COLO_FLAG"

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

# Cleaver - https://github.com/jdan/cleaver
cleave() {
  md=$1
  html=$2
  if [ -z "${html}" ]; then; html=$1; fi
  cleaver ${md}.md && open ${html}.html
}


###
# Comcast
###

mri() {
  PROJECT_ROOT='/Users/asfallows/comcast/xfinity_home'

  if [[ -z $1 || $1 == "on" ]]; then
    echo "Turning MRI Ruby on!"
    rvm use 2.1.3
    sed -i.bak s/1\.9\.3/2.1.3/g Gemfile
  elif [[ -n $1 && $1 == "off" ]]; then
    echo "Turning JRuby on..."
    rvm use $(cat $PROJECT_ROOT/.ruby-version)
    sed -i.bak s/2\.1\.3/1.9.3/g Gemfile
  else
    echo "You dun goof'd."
  fi

  rm Gemfile.bak
}
