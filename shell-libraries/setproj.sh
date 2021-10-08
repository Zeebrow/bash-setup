function _z_setproj_remote () {
  ssh homelab "/home/zeebrow/.local/bin/scripts/setproj $@"
}
export -f _z_setproj_remote
alias setproj=_z_setproj_remote
