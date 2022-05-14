_complete_sift_dotfiles () {
  local options=(
encrypt
decrypt
)
	[ "${#COMP_WORDS[@]}" -gt 2 ] && return

	COMPREPLY=($(compgen -W "${options[*]}" "${COMP_WORDS[1]}"))
	
	_deboog(){
		# on single <tab>
		echo "$1 ------ $2 ---------- $3"
		echo "${options[*]}"
	}
	#_deboog
}

#complete -C _complete_vic vic
#complete -X "$nocomplete" -F _complete_note note
complete -F _complete_sift_dotfiles sift-dotfiles.sh
