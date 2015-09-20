#!/bin/bash

if (( $# != 1 ))
then
  echo "Usage: Destination Root path is required."
  exit 1
fi

rootDest=$1
SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

link() {
  origin=$1
  dest=$2

  ln -s $SCRIPTPATH/$origin $dest
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

# subfolder required

mkdir -p $rootDest/.sbt/0.13/plugins
link .sbt/0.13/plugins/plugins.sbt $rootDest/.sbt/0.13/plugins

mkdir -p $rootDest/.lein
link .lein/profiles.clj            $rootDest/.lein

mkdir -p $rootDest/.config
link .config/up                    $rootDest/.config
link .config/ranger                $rootDest/.config

# folders
link .vim        $rootDest
link .zprezto    $rootDest
