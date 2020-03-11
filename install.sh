#!/bin/sh

#
# Before running this file:
#   - Mac? Install brew - /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
#   - install git
#   - clone: http://github.com/kaldrenon/home
#

# package installs
HAS_BREW=$(which brew)
if [ ${HAS_BREW} = "brew not found" ]; then
  sudo apt-get update
  sudo apt-get install -y $(cat packages)
else
  brew bundle
fi

# nvm
if [ -x $(command -V nvm) ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi

# rvm
if [ -x $(command -V rvm) ]; then
  gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  \curl -sSL https://get.rvm.io | bash -s stable --ruby
fi

# symlinks
./symlink.sh

# neovim
pip3 install neovim
mkdir -p ~/.config/nvim
ln -s ${pwd}/.vimrc ~/.config/nvim/init.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
