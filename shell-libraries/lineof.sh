lineof() { 
	[ ${#1} -ne 1 ] && printf "only single char allowed\n" && return 1
	for i in `seq 1 $(tput cols)`; do printf "$1"; done 
}
export -f lineof
