lineof() { for i in `seq 1 $(tput cols)`; do printf "$1"; done }
export -f lineof
