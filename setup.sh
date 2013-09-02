#!/bin/bash

set -e
set -u

ddir=$(dirname $(realpath $0))

to_link=(bashrc emacs.d gitconfig hgrc oh-my-zsh screenrc setup.sh vim vimrc zshrc)
for f in ${to_link[@]}; do
  echo $f
  rm -rf $HOME/.$f
  ln -s ${ddir}/$f $HOME/.$f
done
