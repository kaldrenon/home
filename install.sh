#!/bin/sh
# apt-get installs
sudo apt-get update
sudo apt-get install -y $(cat packages)

# symlinks
./symlink.sh

# repos

# ruby
\curl -sSL https://get.rvm.io | bash -s stable
rvm install ruby-head

# etc


