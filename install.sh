### RVM INSTALL
\curl -L https://get.rvm.io | bash -s stable

rvm install 1.9.3
rvm use 1.9.3 --default
gem install bundler
bundle install
ruby install.rb

### VIM INSTALL

# Clone vundle
git clone git://github.com/gmarik/vundle .vim/bundle/vundle

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

### MISC CONFIGS
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

