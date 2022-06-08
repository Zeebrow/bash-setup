#!/bin/bash

function debug () {
	echo "$0"
	echo "$BASH_SOURCE"
	basename "$0"
	pwd
	realpath "$0"
	realpath "$BASH_SOURCE"
	echo "-------------"
}

_bn=$(pwd)/$(basename "$0")
_rp=$(realpath "$0")
[ "$_bn" != "$_rp" ] && echo "Must be run from same directory. Exiting!" &&  exit 1

function prep_home () {
	mkdir -vp "$HOME/.local/bin/scripts/lib"
	mkdir -vp "$HOME/.local/bin/scripts/completions"
	mkdir -vp "$HOME/.local/etc"
	mkdir -vp "$HOME/.local/var/run"
	mkdir -vp "$HOME/.local/var/log"
  mkdir -vp "$HOME/.local/lib/perl5"
  mkdir -vp "$HOME/.config/git"
}

function install_scripts () {
	source ./shell-libraries/install-libs.sh
	source ./scripts/install-scripts
}

function install_completions () {
  cp -v completions/*.bash "$HOME/.local/bin/scripts/completions"
}

function install_dotfiles () {
	source ./dotfiles/install-dotfiles
}

function configure_vim() {
  which vim 2>&1 >> /dev/null
  [ "$?" -gt 0 ] && echo 'vim is not installed!' && return 1
  if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
    echo installing vim plugins...
     curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
     vim +'PlugInstall --sync' +qa
  fi
}

function configure_git () {
  which git 2>&1 >> /dev/null
  [ "$?" -gt 0 ] && echo git is not installed! && return 1
  echo configuring git...
  git config --global user.name Zeebrow
  git config --global init.defaultBranch master
  git config --global core.pager less
  git config --global core.editor vim
}

function do_installs() {
  prep_home
  configure_vim
  configure_git
	install_dotfiles install
	install_scripts
  install_completions
}

function do_diffs() {
  let _rc=0
  cd dotfiles 
  ./install-dotfiles diff
  rc=$((_rc + $?))
  return "$_rc"
}

function usage () {
	echo "${0##*/} [all|diff|help]"
}

case "$1" in
  all) do_installs;;
  diff) do_diffs;;
  *) usage;;
esac
