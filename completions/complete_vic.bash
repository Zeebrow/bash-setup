_complete_vic () {
for s in `find "$HOME/.local/bin/scripts" -maxdepth 1 -type f -executable`; do
		file "$s" | grep -qi ASCII;
		if [ "$?" -ne 0 ]; then
			# aint nobody got time to vim a binary file 
			COMPREPLY+=(${s##*/}\*)
		else
			COMPREPLY+=(${s##*/})
		fi
	done
}

complete -F _complete_vic vic
