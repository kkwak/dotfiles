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
  dest=$2

  ln -s $SCRIPTPATH/$origin $dest
  COUNTER=$((COUNTER+1))
}

# root files:
link .gitconfig  $rootDest
link .mongorc.js $rootDest
link .spacemacs  $rootDest
link .tmux.conf  $rootDest
link .vimrc      $rootDest
link .zlogin     $rootDest
link .zlogout    $rootDest
link .zpreztorc  $rootDest
link .zprofile   $rootDest
link .zshenv     $rootDest
link .zshrc      $rootDest

# folders
link .vim        $rootDest
link .zprezto    $rootDest

# subfolder required
mkdir -p $rootDest/.sbt/0.13/plugins
link .sbt/0.13/plugins/plugins.sbt $rootDest/.sbt/0.13/plugins

mkdir -p $rootDest/.lein
link .lein/profiles.clj            $rootDest/.lein

mkdir -p $rootDest/.config/ranger
link .config/update-submodules.sh    $rootDest/.config
link .config/ranger/commands.py      $rootDest/.config/ranger
link .config/ranger/commands_full.py $rootDest/.config/ranger
link .config/ranger/rc.conf          $rootDest/.config/ranger
link .config/ranger/rifle.conf       $rootDest/.config/ranger
link .config/ranger/scope.sh         $rootDest/.config/ranger

echo "Linked $COUNTER files/folders"
