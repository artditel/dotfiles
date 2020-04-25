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

DIR=$(dirname $0)
(cd $DIR; git submodule update --init)

link_if_missing $DIR/vim          $HOME/.vim
link_if_missing $DIR/gitconfig    $HOME/.gitconfig
link_if_missing $DIR/vimrc        $HOME/.vimrc
link_if_missing $DIR/bashrc       $HOME/.bashrc
link_if_missing $DIR/bash_profile $HOME/.bash_profile

mkdir -p $HOME/.vim/undo
vim +PluginInstall +qall
(cd ~/.vim/bundle/YouCompleteMe; ./install.py --clangd-completer)
