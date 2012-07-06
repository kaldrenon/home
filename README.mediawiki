This is a repo for the stuff I use with Vim. It also includes my zshrc and my tmux.conf. Feel free to use as much or as little is valuable to you.

If you want to use it, just clone the repo and copy .gvimrc, .vimrc, and the .vim folder into your home directory. To use it with GVim on Windows, copy them to C:\Users\Username as _gvimrc, _vimrc, and vimfiles respectively.

There is also an install script in the root directory of the repo, but be careful with it because I'm lazy, so right now it will wipe out any existing version of these files that you might have.

The fastest way to grab this is: <code>git clone git://github.com/kaldrenon/vim-tools; cd vim-tools; ./install.sh</code>

Note that I am using Vundle, so to pick up the plugins I use, you'll want to run <code>:BundleInstall</code> when you start vim for the first time after cloning and installing.
