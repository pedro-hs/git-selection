#!/usr/bin/env bash
#===============================================================================
#NAME
#  uninstall.bash
#
#DESCRIPTION
#  Uninstall gis
 #===============================================================================

remove_tmp_files() {
  local file_names=("ac0ad678bac3406dad76e401790dddc7" "92fd9a5b249a4bae9e89fd8384461219")

  for file_name in ${file_names[@]}; do
    local path="/tmp/$file_name"
    [[ -f $path ]] && rm $path
  done
}

uninstall() {
  remove_tmp_files

  rm -rf ~/.gis
  sed -i "/gis.bash/d" ~/.bashrc

  echo "Done! Close this terminal and open a new one"
}

uninstall
