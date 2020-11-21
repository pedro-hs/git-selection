#!/usr/bin/env bash
#===============================================================================
#NAME
#  gis.bash
#
#DESCRIPTION
#  Call gis commands
#===============================================================================

case "$@" in
  add|a) source ~/.gis/add.bash;;
  *) echo 'invalid argument';;
esac
