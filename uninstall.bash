#!/usr/bin/env bash
#===============================================================================
#NAME
#  uninstall.bash
#
#DESCRIPTION
#  Uninstall gs
#===============================================================================

remove_tmp_files() {
  local file_names=("ac0ad678bac3406dad76e401790dddc7"
  "92fd9a5b249a4bae9e89fd8384461219"
  "4e864ba6-be5a-4a2e-92d9-c78f8142befe"
  "3ccfccd7-a702-4b4e-b024-d94ee9107476"
  "37eb0874-ad2b-4b7b-a6cc-e48054581630"
  "a3f223d9-239c-43d7-bc60-2ab6b40fe0b7"
  "fd27537f-e868-472b-b62b-4978733be288"
  "4ee1e390-e999-4858-affe-2f2b4cd79e01")

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
