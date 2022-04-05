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

function preflight() {
	echo
}

function prep_home () {
  # dont count on XDG_ vars being set
	mkdir -vp "$HOME/.local/bin/scripts/lib"
	mkdir -vp "$HOME/.local/bin/scripts/completions"
	mkdir -vp "$HOME/.local/etc"
	mkdir -vp "$HOME/.local/var/run"
	mkdir -vp "$HOME/.local/var/log"
	mkdir -vp "$HOME/.local/share/go"
		ln -vsf "$HOME/Documents/projects/go" "$HOME/.local/share/go"
		ln -vs "$REPOS/go" "$HOME/.local/share/go"
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

function install_ssh () {
	mkdir -vp "$HOME/.ssh"
	source ./ssh/install-ssh
}

function do_installs() {
  prep_home
	install_dotfiles install
	install_scripts
  install_completions
}

function usage () {
	echo "${0##*/} [all|diff|help]"
}

do_installs
