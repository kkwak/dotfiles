#!/bin/zsh

FULLPATH_FILE="$(test -L "$0" && readlink "$0" || echo "$0")"
SCRIPTPATH=$(dirname $FULLPATH_FILE)

echo "=== Updating dotfiles repo ==="
pushd $SCRIPTPATH

git fetch --all --recurse-submodules && git submodule update
# do not require /master branch
./up.sh

popd
echo 
if [ -d "$HOME/.emacs.d" ]; then
  echo "--- Updating Spacemacs Repo independently ---"
  pushd ~/.emacs.d
  git fetch --all --recurse-submodules && git submodule update
  $SCRIPTPATH/up.sh
  popd
fi

