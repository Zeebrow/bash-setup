#!/bin/bash
# 
# install files in scripts direectory
LIBS_DIR=$HOME/.local/bin/scripts/libs

function debug () {
echo "bash_source: $BASH_SOURCE"
echo "calling script (\$0): $0"
echo "realpath $(realpath $BASH_SOURCE)"
this_script=${BASH_SOURCE/*\//}
this_script=${this_script/\//}
echo "this script: $this_script"
}

this_script=${BASH_SOURCE/*\//}
this_script=${this_script/\//}

if [ "$0" == "$BASH_SOURCE" ]; then
	_bn="`pwd`/$(basename $0)"
	_rp="$(realpath $0)"
	[ "$_bn" != "$_rp" ] && echo "Must be run from same directory. Exiting!" &&  exit 1
	echo installing scripts
	this_dir=`pwd`
else
	# echo "this was sourced"
	this_dir=$(pwd)/shell-libraries
fi

echo installing scripts...
test -d $LIBS_DIR ||  mkdir -vp $LIBS_DIR
for lib in `ls $this_dir`; do
	[ "$lib" == "$this_script" ] && continue
	cp -v $this_dir/$lib $LIBS_DIR
done
