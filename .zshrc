# Antigen bundles
source ~/antigen.zsh

antigen bundle emallson/gulp-zsh-completion
antigen bundle olivierverdier/zsh-git-prompt
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle bobthecow/git-flow-completion
antigen bundle docker
antigen bundle felixr/docker-zsh-completion
antigen apply

source ~/.config/tmuxinator.zsh

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

#PROMPT='%{$fg_bold[green]%}%T%{$reset_color%} %{$fg_bold[blue]%}%n|%m%{$reset_color%} %2~ $(git_super_status)→ '
PROMPT="%{$fg_bold[green]%}%T%{$reset_color%} %{$fg_bold[blue]%}%n%{$reset_color%} %2~ → "
RPROMPT="" # prompt for right side of screen

unsetopt AUTO_CD

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
alias ag='ag --path-to-ignore ~/.ignore'

alias srv='http-server'
alias htp='http-prompt'

alias wat='man'

alias drop='cd ~/Dropbox/'
alias code='cd ~/Dropbox/code'
alias cdh='cd ~/home'

alias clip="nc localhost 8377"

alias hl="history -D -n -1"

# Docker and Vagrant
alias vup='vagrant up'
alias vdown='vagrant halt'
alias vkill='vagrant halt && vagrant destroy -f'

alias kiex="~/.kiex/bin/kiex"

shovel() ( cd ~/cmm/dev && ./script/run shovel "$@"; )

# Process search
alias pax="ps ax | ag"

alias p='python3'
alias pip='pip3'

alias crawl="/Users/afallows/Dropbox/games/crawl.app/Contents/Resources/crawl"

# NeoVim
HOST_OS=`uname`

# Ubuntu/Debian
if [[ $HOST_OS = 'Linux' ]]; then
  alias agi="sudo apt-get install -y"
  alert() {
    echo $1
  }
fi

# Mac OS only
if [[ $HOST_OS = 'Darwin' ]]; then
  alias agi="brew install -y"

  # Voices
  alert() {
    (say -v 'Victoria' "$@" </dev/null &>/dev/null &)
  }

  alias bsl="brew services list"
  alias bsr="brew services restart"
fi

# PostgreSQL
alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

####
# Vim and NeoVim
####

HAS_NVIM=`which nvim`
if [ ${HAS_NVIM} = "nvim not found" ]; then
  VIM_BIN="vim"
else
  VIM_BIN="nvim"
fi


EDITOR="${VIM_BIN}"
export EDITOR
VISUAL="${VIM_BIN}"
export VISUAL
alias v="${VIM_BIN}"
alias nv="${VIM_BIN}"
alias vpi="${VIM_BIN} -c PluginInstall"
alias git="hub"

alias dotfiles="cd ~/home && ${VIM_BIN} -o .vimrc .zshrc .tmux.conf .githelpers .gitconfig"

alias vimp="${VIM_BIN} --startuptime ~/vim_start.log"

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

# Open all files breaking rubocop rules
vimcops() {
  ${VIM_BIN} -o `rubocop -f fi`
}

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

rspeak () {
  bundle exec rspec $@
  if [ $? -eq 0 ]; then
    alert "tests are green"
  else
    alert "tests are red"
  fi
}

######
# Git(Hub)
######
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
# Utility
######

# Quick alias to get disk usage of a dir
usage(){
  du -hc $1 | grep total
}

# multiple silver-search
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

alias mux="tmuxinator"
alias tma="tmux attach -t"

# Print all the color names for TMUX highlighting
tmuxcolors() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolor${i}\n"
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

function mcd() { mkdir -p $1 && cd $1; }

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

# Ensure local/bin precedes bin, add Dropbox to PATH
PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
PATH="$PATH:/usr/local/opt/python/libexec/bin:$HOST_PATH:/usr/local/bin:$HOME/Dropbox/bin:/usr/local/share/npm/bin:$HOME/.local/bin"

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

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

PATH=$PATH:$HOME/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# if [[ -e "$(pwd)/.ruby-version" ]] ; then
#   rvm use $(cat .ruby-version) > /dev/null;
# fi
