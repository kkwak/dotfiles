#!/bin/zsh

FULLPATH_FILE="$(test -L "$0" && readlink "$0" || echo "$0")"
SCRIPTPATH=$(dirname $FULLPATH_FILE)

echo "=== Updating dotfiles repo ==="
pushd $SCRIPTPATH
# do not require /master branch
./up.sh

git submodule sync
git submodule update --init --recursive
popd
echo 
if [ -d "$HOME/.emacs.d" ]; then
  echo "--- Updating Spacemacs Repo independently ---"
  pushd ~/.emacs.d
  git pull --recurse-submodules && git submodule update
  popd
fi

