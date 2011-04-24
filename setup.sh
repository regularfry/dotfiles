#!/bin/bash

set -e
set -u

ddir=$(dirname $(realpath $0))

to_link=(bashrc emacs.d gitconfig hgrc oh-my-zsh screenrc setup.sh vim zshrc)
for f in ${to_link[@]}; do
  echo $f
  ln -s ${ddir}/$f $HOME/.$f
done
