#!/usr/bin/env bash
#===============================================================================
#NAME
#  gs.bash
#
#DESCRIPTION
#  Call gs commands
#===============================================================================

case "$@" in
  add|a) source ~/.gs/files.bash "add";;
  reset|r) source ~/.gs/files.bash "reset";;
  rm) source ~/.gs/files.bash "rm";;
  diff|df) source ~/.gs/files.bash "diff";;
  branch|b) source ~/.gs/branches.bash "branch";;
  # "branch -a"|ba) source ~/.gs/branches.bash "branch -a";;
  # "branch -r"|br) source ~/.gs/branches.bash "branch -r";;
  "branch -d"|bd) source ~/.gs/branches.bash "branch -d";;
  "branch -D"|bD) source ~/.gs/branches.bash "branch -D";;
  *) echo -e "Invalid command\nAvailable:\nadd or a\nreset or r\nrm\ndiff or df\nbranch or b\nbranch -a or ba (cooking)\nbranch -r or br (cooking)\nbranch -d or bd";;
esac
