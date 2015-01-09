#!/bin/bash
declare -a files=( .vimrc .tmux.conf .gitconfig .githelpers .zshrc antigen.zsh .vim )
for file in ${files[@]}
do
  ln -s /root/home/$file /root/$file
done
