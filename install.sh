#!/bin/sh
# apt-get installs
sudo apt-get update
sudo apt-get install -y $(cat packages)

# symlinks
./symlink.sh

# repos


# etc


