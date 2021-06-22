#!/bin/bash

function install_scripts () {
	cp colors $HOME/.local/bin/scripts/ && echo installing colors...
}

function cp_bashrc (){
	if test -f $HOME/.bashrc; then
		cp $HOME/.bashrc $HOME/.bashrc.bkup.$(date +%s)
	fi
	echo installing bashrc...
	cp ./.bashrc $HOME
}
function rm_backups (){
	for file in `ls -1 $HOME/.bashrc.bkup.* 2> /dev/null`; do
		echo "removing $file..."
		rm $file
	done
}

if [ $# -eq 0 ]; then
	cp_bashrc
	install_scripts
else
	while [ $# -gt 0 ]; do
		case "$1" in
			--clean) rm_backups;;
			*) ;;
		esac
		shift
	done
fi
