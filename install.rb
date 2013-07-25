pkgs = ['htop','git','build-essential','vlc','guake']
### VIM INSTALL

# Clone vundle
%x[git clone git://github.com/gmarik/vundle .vim/bundle/vundle]

# for each file, remove it if it exists as a plain file or a symlink
%x[if [ -e ~/.vimrc ] || [ -h ~/.vimrc ]
then
  rm ~/.vimrc
fi
ln -s $PWD/.vimrc $HOME/.vimrc 

if [ -e ~/.vim ] || [ -h ~/.vim ]
then
  rm -rf ~/.vim 
fi
ln -s $PWD/.vim $HOME/.vim ]

### MISC CONFIGS
%x[if [ -e ~/.tmux.conf ] || [ -h ~/.tmux.conf ]
then
  rm ~/.tmux.conf 
fi
ln -s $PWD/.tmux.conf $HOME/.tmux.conf 

if [ -e ~/.zshrc ] || [ -h ~/.zshrc ]
then
  rm ~/.zshrc
fi
ln -s $PWD/.zshrc $HOME/.zshrc]
