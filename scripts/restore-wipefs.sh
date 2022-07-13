#!/bin/bash
[ -z "$1" ] && echo provide a device name && exit 1
[ -n "$1" ] && echo why would you run a script without reading it first? && exit 1

function destroy_my_computer(){
#  for bkup in wipefs-$1*.bak; do
#    read -r _ dev offs _ <<< ${bkup//[-.]/ }
#    offs=${offs:2}
#    offs=$((16#$offs))
#    echo -e "$bkup\t$dev\t$offs"
#    dd if="$bkup" of="/dev/$dev" seek="$offs" bs=1 conv=notrunc
#    echo
#  done
:
}
destroy_my_computer $1

function useful_info_about_my_disks_and_stuff() {
# non-destructive (read: safe) commands
lsblk --fs
partx --show /dev/sda
wipefs -O DEVICE,TYPE,LABEL,OFFSET,LENGTH,UUID,USAGE /dev/sda
wipefs -JO DEVICE,TYPE,LABEL,OFFSET,LENGTH,UUID,USAGE /dev/sda1
partx --list-types
}
