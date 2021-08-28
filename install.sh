#!/bin/bash

function debug () {
	echo $0
	echo $BASH_SOURCE
	echo $(basename $0)
	pwd
	realpath $0
	realpath $BASH_SOURCE
	echo "-------------"
}

_bn="`pwd`/$(basename $0)"
_rp="$(realpath $0)"
[ "$_bn" != "$_rp" ] && echo "Must be run from same directory. Exiting!" &&  exit 1

function preflight() {
	echo
}

function prep_home () {
	mkdir -vp "$HOME/.local/bin/scripts"
	mkdir -vp "$HOME/.local/bin/scripts/lib"
	mkdir -vp "$HOME/.local/etc"
	mkdir -vp "$HOME/.local/var/run"
	mkdir -vp "$HOME/.local/var/log"
	mkdir -vp "$HOME/.local/share/go"
		ln -vs "$HOME/Documents/go" "$HOME/.local/share/go"
		ln -vs "$REPOS/go" "$HOME/.local/share/go"
}

function install_scripts () {
	source ./shell-libraries/install-libs.sh
	source ./scripts/install-scripts
}

function install_dotfiles () {
	source ./dotfiles/install-dotfiles
}

function install_vimfiles () {
	mkdir -vp $HOME/.vim
	source ./vim/install-vim
}

function install_ssh () {
	mkdir -vp $HOME/.ssh
	source ./ssh/install-ssh
}

function do_diffs () {
	let rtns=0
	install_dotfiles diff
	rtns=$((rtns + "$?"))
	# addl. diffs here
}

function do_installs() {
	install_dotfiles install
	install_scripts
	install_vimfiles
}

function usage () {
	echo "${0##*/} [all|diff|help]"
}

case "$1" in 
	all) do_installs ;;
	diff) do_diffs ;;
	*) usage ;;
esac
exit 0
