#!/bin/bash -e

function link_if_missing()
{
  SRC=$1
  DEST=$2

  if ! [ -L $DEST ]; then
    ln -ivs $SRC $DEST
  else
    echo "Skipping, link already exists: $SRC"
  fi
}

(cd $PWD; git submodule update --init)

link_if_missing $PWD/vim        $HOME/.vim
link_if_missing $PWD/gitconfig  $HOME/.gitconfig
link_if_missing $PWD/vimrc      $HOME/.vimrc
link_if_missing $PWD/bashrc      $HOME/.bashrc
link_if_missing $PWD/bash_profile      $HOME/.bash_profile

mkdir $HOME/.vim/undo
vim +PluginInstall +qall
. ~/.bashrc
