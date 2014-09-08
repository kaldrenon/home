#!/bin/sh
# apt-get installs
sudo apt-get update
sudo apt-get install $(cat packages)

# symlinks
for file in $(ls dotfiles); do
  ln -s $(pwd)/$file $HOME/$file
done

# repos

# ruby

# etc


