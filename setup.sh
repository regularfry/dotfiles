#!/bin/bash

set -e
set -u

ddir=$(dirname $(realpath $0))

to_link=(bashrc emacs.d gitconfig hgrc oh-my-zsh screenrc vim vimrc zshrc shell)
for f in ${to_link[@]}; do
  echo $f
  rm -rf $HOME/.$f
  ln -s ${ddir}/$f $HOME/.$f
done

mkdir -p $HOME/bin
cp -a bin/* $HOME/bin/
