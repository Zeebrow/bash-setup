declare -A emojis

add(){
  [ "$#" -ne 2 ] && return 1
  local n="$2"
  local u='\u'
  for i in "${!emojis}"; do
    [ "$1" == "$i" ] && return 1
  done
  emojis["$1"]="$u$2"
  export emojis
  printf "Added :$1: -> $(emo $2)\n"
}

emo(){ local u='\U'; printf "$u${emojis[$1]}"; }

list(){
  declare -a emolines
  for e in "${!emojis[@]}"; do 
    emolines+=("$e: $(emo $e)")
    echo "${emolines[@]}"
  done
}

export -f emo
complete -W "${!emojis[@]}" emo
[ "${#COMP_WORDS[@]}" -gt 2 ] && return
