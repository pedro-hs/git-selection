#!/usr/bin/env bash
#===============================================================================
#NAME
#  uninstall.bash
#
#DESCRIPTION
#  Uninstall gis
#===============================================================================

remove_tmp_files() {
  local file_names=("ac0ad678bac3406dad76e401790dddc7")

  for file_name in ${file_names[@]}; do
    local path="/tmp/$file_name"
    [[ -f $path ]] && rm $path
  done
}

uninstall() {
  remove_tmp_files
  rm -rf ~/.gis
  echo 'Done! Close this terminal and open a new one'
}

uninstall
