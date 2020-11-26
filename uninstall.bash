#!/usr/bin/env bash
#===============================================================================
#NAME
#  uninstall.bash
#
#DESCRIPTION
#  Uninstall gs
 #===============================================================================

remove_tmp_files() {
  local file_names=("ac0ad678bac3406dad76e401790dddc7" "92fd9a5b249a4bae9e89fd8384461219" "3ccfccd7-a702-4b4e-b024-d94ee9107476" "4e864ba6-be5a-4a2e-92d9-c78f8142befe")

  for file_name in ${file_names[@]}; do
    local path="/tmp/$file_name"
    [[ -f $path ]] && rm $path
  done
}

uninstall() {
  remove_tmp_files

  rm -rf ~/.gs
  sed -i "/gs.bash/d" ~/.bashrc

  echo "Done! Close this terminal and open a new one"
}

uninstall
