#!/bin/bash

rootDest=$1
if [[ -z "$rootDest" ]]
then
  echo "Destination was not specified: defaulting to $HOME"
  read -p "Are you sure? [y/n]: " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    rootDest="$HOME"
  else
    echo "Please specify the destination..."
    exit 1
  fi
fi

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
COUNTER=0

link() {
  origin=$1
  fullPathDest="$rootDest/$origin"

  if ! [ -L $fullPathDest ]; then 
    ln -s $SCRIPTPATH/$origin $fullPathDest
    COUNTER=$((COUNTER+1))
  else
    echo "Link exists at: $fullPathDest"
  fi
}

# root files:
link .gitconfig
link .spacemacs
link .tmux.conf
link .vimrc
link .zlogin
link .zlogout
link .zpreztorc
link .zprofile 
link .zshenv
link .zshrc

# folders
link .vim
link .zprezto

# subfolder required
mkdir -p $rootDest/.sbt/0.13/plugins
link .sbt/0.13/plugins/plugins.sbt

mkdir -p $rootDest/.lein
link .lein/profiles.clj

mkdir -p $rootDest/.config/ranger
link .config/update-submodules.sh
link .config/ranger/commands.py
link .config/ranger/commands_full.py
link .config/ranger/rc.conf
link .config/ranger/rifle.conf
link .config/ranger/scope.sh

echo "Linked $COUNTER files/folders"
