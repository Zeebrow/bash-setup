# not sanitary. not sure if useful.
log(){
	let level="$1"
	shift
	msg="$@"
	indicator='!'
	printf "%.s!" `seq 1 ${level}`; printf " "
	printf "$msg"
	printf " "; printf "%.s!" `seq 1 ${level}` ; printf "\n"
}
export -f log
