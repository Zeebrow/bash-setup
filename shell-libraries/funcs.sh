# prupose is to print a function, as it is dispayed with `declare -f`
get_func () {
  [ -z "$1" ] && echo no && return 1
  f=$(mktemp)
  declare -f > "$f"
  let begl=$(grep -n "^$1 \(\)" "$f" | cut -d: -f1)
  let linc=$(tail -n +"$begl" "$f" | grep -nm 1 -x "\}" | cut -d: -f1 )
  tail -n +"$begl" "$f" | head -"$linc"
  rm "$f"
}

_complete_get_func () {
  :
}
