#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
    --exclude "README.md" --exclude "LICENSE" --exclude "monokai.vim" -avh --no-perms . ~;
  source ~/.bash_profile;
}

if [ ! -d "~/.vim/" ]; then
  mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim;
  cp monokai.vim ~/.vim/colors/;
fi;

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;
