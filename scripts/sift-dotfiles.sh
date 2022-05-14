#!/bin/bash
# encrypt all those dot files
function onexit () {
  echo
  echo received SIGINT, cleaning up...
  unset IFS
  tput cnorm
  exit 1
}
trap onexit SIGINT

usage() {
  echo "$0 encrypt|restore"
  exit 1
}

[ "$PWD" != "$HOME" ] && echo 'need to run from ~' && exit 1
secrets_dir="$HOME/.secrets"
[ ! -d "$secrets_dir" ] && mkdir -v "$secrets_dir"
PASSPH=
SECRET_FILES=()
OLDIFS="$IFS"

function get_passwd () {
  # shoutout to tom, btw
  if [ "$1" == '-d' ]; then
    read -s -p "Password for decryption: " passd < /dev/tty
    echo
    PASSPH="$passd"
    return 0
  else
    read -s -p "Password to encrypt with: " pass1 < /dev/tty
    echo
    [ ! -n "$pass1" ] && echo password must not be 0 length && exit 1
    read -s -p "Repeat password: " pass2 < /dev/tty
    echo
    if [ "$pass1" == "$pass2" ]; then
      PASSPH="$pass1"
    else
      echo passwords do not match
      exit 1
    fi
    return 0
  fi
}

function enc_move () {
  src=$1
  tgt=$2
  openssl enc -aes-256-cbc -a -in "$1" -out "$2" -salt -pass "pass:$PASSPH" 2>/dev/null
  return 0
}

function decrypt_restore () {
  src=$1
  tgt=$2
  echo "from=$1 to=$2"
  openssl enc -aes-256-cbc -d -a -in "$1" -out "$2" -salt -pass "pass:$PASSPH" 2>/dev/null
  return 0
}

function get_target_files () {
  [ -z "$PASSPH" ] && echo no encryption passphrase specified! && exit 1
  tput civis
  while IFS= read -u 4 -d '' f; do 
    f=${f##*/}
    printf "(y/N) encrypt file: %s?\r" "$f"
    read -r -s ans
      case "$ans" in
      y) echo -e "\033[92m✔\033[0m $f                           "; SECRET_FILES+=("$f");;
      *) echo -e "\033[31m✘\033[0m $f                           ";;
      esac
  done 4< <(find . -maxdepth 1 -type f -name ".*" -print0)
  IFS="$OLDIFS"
  tput cnorm
}


function do_encrypt_archive () {
  get_passwd
  get_target_files
  echo "${#SECRET_FILES[*]} to encrpyt."
  read -r -p "clean secrets directory? (backups are on YOU!) (y/N): " _cln </dev/tty
  [ "$_cln" == 'y' ] && rm -rf "$secrets_dir"; mkdir "$secrets_dir"
  echo writing files...
  while IFS= read -r -d ' ' tgt; do
    enc_move "$tgt" "$secrets_dir/$tgt"
  done <<< "${SECRET_FILES[@]}"
  echo done
}

function do_decrypt_restore () {
  get_passwd -d

  printf "directory to find encrypted files (default: %s): " "$secrets_dir"
  read restore_from </dev/tty
  [ -z "$restore_from" ] && restore_from="$secrets_dir"
  [ ! -d "$restore_from" ] && echo -e "\033[31m✘\033[0m" && echo "directory does not exist: $restore_from" && exit 1
  restore_from=${restore_from%/}
  echo -e "\033[92m✔\033[0m $restore_from"

  printf "retore files to directory (default: %s): " "$HOME"
  read -r  restore_to </dev/tty
  [ -z "$restore_to" ] && restore_to="$HOME"
  [ ! -d "$restore_to" ] && echo -e "\033[31m✘\033[0m"&& echo "directory does not exist: $restore_to" && exit 1
  restore_to=${restore_to%/}
  echo -e "\033[92m✔\033[0m $restore_to"

  while IFS= read -u 4 -d '' f; do 
    decrypt_restore "$f" "$restore_to/$(basename $f)"
  done 4< <(find "$restore_from" -maxdepth 1 -type f -name ".*" -print0)

  return 0
}


case "$1" in
  encrypt) do_encrypt_archive;;
  decrypt) do_decrypt_restore;;
  *) usage;;
esac

#do_decrypt_restore
#do_encrypt_archive
