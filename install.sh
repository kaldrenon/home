#!/bin/sh
# apt-get installs
HAS_BREW=`which brew`
if [ ${HAS_BREW} = "brew not found" ]; then
  sudo apt-get update
  sudo apt-get install -y $(cat packages)
else
  brew bundle
fi

# symlinks
./symlink.sh
