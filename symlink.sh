#!/bin/bash
declare -a files=( .vimrc .tmux.conf .gitconfig .githelpers .zshrc antigen.zsh .vim )
for file in ${files[@]}
do
  ln -s ${HOME}/home/$file ${HOME}/$file
done
