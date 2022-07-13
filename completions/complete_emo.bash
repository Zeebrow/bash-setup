nocomplete=()
_complete_emo () {
	# $1 = name of command to be completed
	# $2 = word being completed
	# $3 = "word preceding the word being completed"
	## so $3 = $1 when completing the command's first arg
	
	# Stop requesting completions if there is anything already completed
	[ "${#COMP_WORDS[@]}" -gt 2 ] && return
  local _emoji_names=(`emo -l | cut -d' ' -f1`)
	COMPREPLY=($(compgen -W "${_emoji_names[*]}" "${COMP_WORDS[1]}"))
	
	_deboog(){
		# on single <tab>
		echo "$1 ------ $2 ---------- $3"
		echo "${_emoji_names[*]}"
		echo "NOCOMPLETE $nocomplete"
	}
	#_deboog
}

complete -X "$nocomplete" -F _complete_emo emo
alias emos='emo -l'
