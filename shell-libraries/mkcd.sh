# shoutout to DaveChurchill
function mkcd () {
  mkdir "$1"
  cd "$1"
}

export -f mkcd
