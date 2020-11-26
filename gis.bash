#!/usr/bin/env bash
#===============================================================================
#NAME
#  gis.bash
#
#DESCRIPTION
#  Call gis commands
#===============================================================================

case "$@" in
  add|a) source ~/.gis/files.bash "add" "ac0ad678bac3406dad76e401790dddc7";;
  reset|r) source ~/.gis/files.bash "reset" "92fd9a5b249a4bae9e89fd8384461219";;
  rm) source ~/.gis/files.bash "rm" "4e864ba6-be5a-4a2e-92d9-c78f8142befe";;
  diff|df) source ~/.gis/files.bash "diff" "3ccfccd7-a702-4b4e-b024-d94ee9107476";;
  *) echo -e "Invalid argument\nAvailable: add reset rm diff";;
esac
