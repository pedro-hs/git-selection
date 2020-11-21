#!/usr/bin/env bash
#===============================================================================
#NAME
#  add.bash
#
#DESCRIPTION
#  Execute git add in gis
#===============================================================================

get_items() {
  local git_status="$( git status -su )"
  local position="$1"
  local items

  while IFS= read item; do
    local working_tree="${item:1:1}"
    [[ $working_tree != ' ' ]] && items+="|$item"
  done <<< "$git_status"

  echo "${items:1}"
}

get_selected_items() {
  IFS='|' read -r -a items <<< "$1"
  local selected_items

  for index in ${selected[@]}; do
    selected_items+=" ${items[index]:3}"
  done

  echo "$selected_items"
}

git_add() {
  local items=("$( get_items )")
  [[ $items == '' ]] && echo 'No more items to add' && return

  local selected
  local output_id='ac0ad678bac3406dad76e401790dddc7'
  local input_path="/tmp/$output_id" && rm -f $input_path
  local checkbox_sh="$( dirname "$BASH_SOURCE" )/checkbox.bash"

  while source $checkbox_sh --message="git add" --options="$items" --multiple --index --output="$output_id"; do
    if [[ -e $input_path ]]; then
      selected=$( cat $input_path )
      [[ $selected == 'Exit' ]] && echo 'git add canceled' && return
      [[ $selected == 'None selected' ]] && echo 'git add what?' && return
      rm -f $input_path
      break
    fi

    sleep 1
  done

  local selected_items=$( get_selected_items "$items" )

  git add $selected_items
  git status -su
}

git_add
