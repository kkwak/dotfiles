#!/bin/zsh


SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
SCRIPTPATH=$SCRIPTPATH/../

echo Updating Prezto Repo
pushd $SCRIPTPATH/.zprezto
git pull && git submodule update --init --recursive
popd

echo Updating Vim Repo
pushd $SCRIPTPATH/.vim
git submodule sync; git submodule update
popd


if [ -d "$HOME/.emacs.d" ]; then
  echo Updating Spacemacs Repo independently
  pushd ~/.emacs.d
  git pull 
  git submodule sync; git submodule update
  popd
fi

