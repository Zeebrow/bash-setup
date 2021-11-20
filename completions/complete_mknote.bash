# complete_note.bash
# source me

_complete_mknote () {

  local mynotes=()

	[ "${#COMP_WORDS[@]}" -gt 2 ] && return

	for s in `find "$HOME/.local/share/notes" -maxdepth 1 -type f `; do
	#for s in `ls -1 $HOME/.local/share/notes`; do
    _s=${s##*/}
    mynotes+=(${_s})

    # uncomment to remove the .md file extension when completing
    #mynotes+=(${_s%.md})
	done

	COMPREPLY=($(compgen -W "${mynotes[*]}" "${COMP_WORDS[1]}"))
	#COMPREPLY=($(compgen -W "${mynotes[*]}" ))
	
	_deboog(){
		# on single <tab>
		echo "$1 ------ $2 ---------- $3"
		echo "${mynotes[*]}"
	}
	#_deboog
}

#complete -C _complete_vic vic
#complete -X "$nocomplete" -F _complete_note note
complete -F _complete_mknote mknote
