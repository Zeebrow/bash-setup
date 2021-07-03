function vactivate(){
test -n "$VIRTUAL_ENV" && printf "virtualenv $VIRTUAL_ENV already active. Nothin' doin'.\n" && exit 1
# @configurable
venvs_home=$HOME/.venvs/
venvs=(`ls -1 $venvs_home`)
_dirpath=(${PWD//// })
if test -z "$VIRTUAL_ENV"; then
  for dir in "${_dirpath[@]}"; do
    for v in "${venvs[@]}"; do
      [[ "$v" =~ "$dir" ]] && echo "$venvs_home$v/bin/activate" && source $venvs_home$v/bin/activate
      done
  done
fi
}

export -f vactivate
