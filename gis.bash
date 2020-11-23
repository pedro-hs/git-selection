#!/usr/bin/env bash
#===============================================================================
#NAME
#  gis.bash
#
#DESCRIPTION
#  Call gis commands
#===============================================================================

case "$@" in
  add|a) source ~/.gis/files.bash 'add' 'ac0ad678bac3406dad76e401790dddc7';;
  reset|r) source ~/.gis/files.bash 'reset' '92fd9a5b249a4bae9e89fd8384461219';;
  *) echo 'invalid argument';;
esac
