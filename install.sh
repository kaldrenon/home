#!/bin/sh

# Setup:
#
# - brew install things (if OSX)
# - apt-get install things (if Linux)
# - symlink a pile of things to ~
# apt-get installs
echo "Setting up dotfiles"

if [[ $HOST_OS = 'Linux' ]]; then
  echo "Installing rcm with apt-get"
  sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
  sudo apt-get update
  sudo apt-get install rcm
fi

if [[ $HOST_OS = 'Darwin' ]]; then
  echo "Installing rcm with brew"
  brew tap thoughtbot/formulae
  brew install rcm
fi

