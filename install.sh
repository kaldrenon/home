# for each file, remove it if it exists as a plain file or a symlink
if [ -e ~/.vimrc ] || [ -h ~/.vimrc ]
then
  rm ~/.vimrc
fi
ln -s $PWD/.vimrc $HOME/.vimrc 

if [ -e ~/.vim ] || [ -h ~/.vim ]
then
  rm -rf ~/.vim 
fi
ln -s $PWD/.vim $HOME/.vim 

if [ -e ~/.tmux.conf ] || [ -h ~/.tmux.conf ]
then
  rm ~/.tmux.conf 
fi
ln -s $PWD/.tmux.conf $HOME/.tmux.conf 

if [ -e ~/.zshrc ] || [ -h ~/.zshrc ]
then
  rm ~/.zshrc
fi
ln -s $PWD/.zshrc $HOME/.zshrc

