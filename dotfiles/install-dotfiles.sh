#!/bin/bash
# 
# install bash dotfiles in $HOME
# moinmoin to https://mywiki.wooledge.org/BashFAQ
this_dir=$(realpath "$0")
this_dir=$(dirname "$this_dir")

working_files_dir="$HOME"
repo_dotfiles_dir=$(dirname $(readlink -f "$0"))
mapfile -t tgt_files < <(find "$repo_dotfiles_dir" ! -name 'install*' ! -name '*.swp' -type f)

unset -f backup
backup() {
  [ "$#" -lt 1 ] && return
  local suffix
  suffix=bkup.$(date +%s)
  # I think this was supposed to accept multiple files, but I suck at bash lel
  #for i in "$@"; do cp -v "$1" "$1$_SFX"; done
  cp -v "$1" "$1.$suffix"
}

function do_install() {
  echo "installing dotfiles for $USER..."

  for df in "${tgt_files[@]}"; do
		#backup "$HOME/.${df##*/}"
		cp -v "$df" "$HOME/.${df##*/}"
		#echo "$repo_dotfiles_dir/${df##*/}-> $working_files_dir/.${df##*/}"
	done
}

function do_diff() {
  local different_files=()
  
  for f in "${tgt_files[@]}"; do
    diff -q "$working_files_dir/.${f##*/}" "$f" >/dev/null
    if [ "$?" -ne 0 ]; then
      echo "[${f##*/}]"
      different_files+=("$f")
      echo "diff $working_files_dir/.${f##*/} $f"
    fi
  done

  return "${#different_files[*]}"
}

case "$1" in
	diff) do_diff; exit "$?";;
	install) do_install;;
	*) echo "install-dotfiles diff|install" && exit 1;;
esac

