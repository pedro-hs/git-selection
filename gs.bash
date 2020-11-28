#!/usr/bin/env bash
#===============================================================================
#NAME
#  gs.bash
#
#DESCRIPTION
#  Call gs commands
#===============================================================================

case "$@" in
  add|a) source ~/.gs/files.bash "add" "ac0ad678bac3406dad76e401790dddc7";;
  reset|r) source ~/.gs/files.bash "reset" "92fd9a5b249a4bae9e89fd8384461219";;
  rm) source ~/.gs/files.bash "rm" "4e864ba6-be5a-4a2e-92d9-c78f8142befe";;
  diff|df) source ~/.gs/files.bash "diff" "3ccfccd7-a702-4b4e-b024-d94ee9107476";;
  branch|b) source ~/.gs/branches.bash "branch" "37eb0874-ad2b-4b7b-a6cc-e48054581630";;
  # "branch -a"|ba) source ~/.gs/branches.bash "branch -a" "a3f223d9-239c-43d7-bc60-2ab6b40fe0b7";;
  # "branch -r"|br) source ~/.gs/branches.bash "branch -r" "fd27537f-e868-472b-b62b-4978733be288";;
  "branch -d"|bd) source ~/.gs/branches.bash "branch -d" "4ee1e390-e999-4858-affe-2f2b4cd79e01";;
  *) echo -e "Invalid command\nAvailable:\nadd or a\nreset or r\nrm\ndiff or df\nbranch or b\nbranch -a or ba (cooking)\nbranch -r or br (cooking)\nbranch -d or bd";;
esac
