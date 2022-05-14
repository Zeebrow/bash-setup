_complete_subsuper() {
  local mynotes=(
    sub
    super
  )
	[ "${#COMP_WORDS[@]}" -gt 2 ] && return

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
complete -F _complete_subsuper subsuper
