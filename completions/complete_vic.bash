# Since this is my first completion script, comments will be verbose-er than necessary

##################
# complete -C vs complete -F
# ready fight

# Choosing -F here because vic is simple. No sub-commands, no --help, --usage, et cetera.
# complete -C will be great for something like `wish`, where it's worth maintaining a 
# separate script, in addition to the .bash completion lib like this one.

# I might be misunderstanding something in the manpage.
# COMP_WORDS (and COMP_CWORD) can only be used with -F, for Shell Function completions.

# -F gets evaluated (read: overrides) before -C. 
# So thats a gotcha.

# <opinions>
# Me myself, I'm a fan of functions over scripts, because smaller units
# Downside is, making a change essentially requires starting a new shell.
# </opinions>

#################


# This function should handle completion for `vic`. vic attempts to 
# open a script for editting. 
# This completion puts an asterisk* after any non-binary script file
# We don't even want to open.

nocomplete=()
_complete_vic () {
	# $1 = name of command to be completed
	# $2 = word being completed
	# $3 = "word preceding the word being completed"
	## so $3 = $1 when completing the command's first arg
	
	# Stop requesting completions if there is anything already completed
	[ "${#COMP_WORDS[@]}" -gt 2 ] && return

	# get an array of scripts, as they exist, before any filtering or name mangling
	myscripts=()
	# 
	#purdy_pre='\033[106m'
	#purdy_suf='\033[0m' 
	for s in `find "$HOME/.local/bin/scripts" -maxdepth 1 -type f -executable`; do
		# aint nobody got time to vim a binary file 
		file "$s" | grep -qi ASCII;
		if [ "$?" -ne 0 ]; then
			# oroginal idea was to simply put an asterisk* after non-ascii files
			# This doesn't seem possible, so we're going to simply exclude them.
			# myscripts+=(${s##*/}\*)
			nocomplete+=(${s##*/})
		else
			myscripts+=(${s##*/})
		fi
	done
	COMPREPLY=($(compgen -W "${myscripts[*]}" "${COMP_WORDS[1]}"))
	
	# want text prepended to completion suggestions
	# i.e. labal for binary files
	_deboog(){
		# on single <tab>
		echo "$1 ------ $2 ---------- $3"
		echo "${myscripts[*]}"
		echo "NOCOMPLETE $nocomplete"
	}
	#_deboog
}

#complete -C _complete_vic vic
complete -X "$nocomplete" -F _complete_vic vic
