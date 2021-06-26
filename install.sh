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

function install_scripts () {
	source ./scripts/install-scripts
}

function install_bashrc (){
	if test -f $HOME/.bashrc; then
		cp $HOME/.bashrc $HOME/.bashrc.bkup.$(date +%s)
	fi
	echo installing bashrc...
	cp ./.bashrc $HOME
}

install_scripts
install_bashrc

