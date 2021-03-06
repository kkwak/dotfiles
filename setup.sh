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

  if [ -e $fullPathDest ]; then
    if [ -L $fullPathDest ]; then
      # if a symlink file exists - then replace link
      echo "Overwriting existing symlink at: $fullPathDest"
      ln -sfn $SCRIPTPATH/$origin $fullPathDest
      COUNTER=$((COUNTER+1))
    else
      # if a non-symlink file exists - leave alone
      echo "(Compare and delete) File exists at: $fullPathDest"
    fi

  elif [ -L $fullPathDest ]; then
    # if an invalid symlink file exists - then replace link
    echo "Overwriting existing symlink at: $fullPathDest"
    ln -sfn $SCRIPTPATH/$origin $fullPathDest
    COUNTER=$((COUNTER+1))

  else
    # if no file exists - link
    echo "Linking ${SCRIPTPATH}/${origin} ${fullPathDest}"
    ln -s $SCRIPTPATH/$origin $fullPathDest
    COUNTER=$((COUNTER+1))
  fi
}

# root files:
link .gitconfig
link .gitignore_global
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
mkdir -p $rootDest/.emacs.d
link .emacs.d/init.el

mkdir -p $rootDest/.config
link .config/tmux-resurrect
link .config/up.sh

mkdir -p $rootDest/.config/ranger
link .config/ranger/commands.py
link .config/ranger/commands_full.py
link .config/ranger/rc.conf
link .config/ranger/rifle.conf
link .config/ranger/scope.sh

echo "Linked $COUNTER files/folders"
