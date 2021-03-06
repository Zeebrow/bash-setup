#!/bin/bash
this_dir=$(realpath "$0")
this_dir=$(dirname "$this_dir")

function prep_home () {
	mkdir -vp "$HOME/.local/bin/scripts/libs"
	mkdir -vp "$HOME/.local/bin/scripts/completions"
	mkdir -vp "$HOME/.local/etc"
	mkdir -vp "$HOME/.local/var/run"
	mkdir -vp "$HOME/.local/var/log"
  mkdir -vp "$HOME/.local/lib/perl5"
  mkdir -vp "$HOME/.config/git"
}

function install_scripts () {
	echo 'AAAAAA source ./shell-libraries/install-libs.sh'
	#works on my machine
	"$this_dir/scripts/install-scripts"
}

function install_completions () {
	mkdir -vp "$HOME/.local/bin/scripts/completions"
  cp -v "$this_dir/completions/*.bash" "$HOME/.local/bin/scripts/completions"
}

function install_dotfiles () {
	#works on my machine
	"$this_dir/dotfiles/install-dotfiles.sh"
}

function configure_vim() {
  which vim 2>&1 >> /dev/null
  [ "$?" -gt 0 ] && echo 'vim is not installed!' && return 1
  if [ -e "$HOME/.vim/autoload/plug.vim" ]; then
    vim +PlugUpdate +qall
  else
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
     vim +'PlugInstall --sync' +qa
  fi
  go version  >/dev/null
  if [ "$?" -eq 0 ]; then 
    vim +'GoInstallBinaries' +qa
  fi
  for f in vim/autoload/*; do
    cp "$f" "$HOME/.vim/autoload"
  done
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
  banner 'prep home'
  prep_home
  banner 'vim'
  configure_vim
  banner 'git'
  configure_git
  banner 'dotfiles'
	install_dotfiles.sh install
  banner 'scripts'
	install_scripts
  banner 'competions'
  install_completions
}

function banner() {
  header=$1
  sep=$(echo "(( $(tput cols) - ${#header}) / 2) - 1" | bc)
  printf "%0.s-" $(seq 1 "$sep")
  printf "%s" "$header"
  printf "%0.s-" $(seq 1 "$sep")
  [ $(echo "${#header} %2" | bc) -eq 0 ] && printf "%s" '-'
  echo
}

function lineof() { 
	for i in `seq 1 $(tput cols)`; do printf "$1"; done 
}

function do_diffs() {
  let _rc=0
  #cd dotfiles 
  banner 'dotfiles'
  dotfiles/install-dotfiles.sh diff
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
