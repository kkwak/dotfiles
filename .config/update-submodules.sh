#!/bin/zsh

git pull --recurse-submodules && git submodule update

if [ -d "$HOME/.emacs.d" ]; then
  echo Updating Spacemacs Repo independently
  pushd ~/.emacs.d
  git pull --recurse-submodules && git submodule update
  popd
fi

