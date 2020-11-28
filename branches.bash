#!/usr/bin/env bash
#===============================================================================
#NAME
#  branches.bash
#
#DESCRIPTION
#  Handle branches in checkbox
#===============================================================================
command=""

get_items() {
  local items
  [[ $command == "branch -d" ]] \
    && local git_branch="$( git branch )" \
    || local git_branch="$( git $command )"

  while IFS= read item; do
    if [[ ${item:0:1} != "*" ]]; then
      items+="|$item"
    fi
  done <<< "$git_branch"

  echo "${items:1}"
}

get_selected_items() {
  local items="$1"
  IFS="|" read -r -a items <<< "$1"
  local selected="$2"

  local selected_items

  for index in ${selected[@]}; do
    selected_items+=" ${items[index]:2}"
  done

  echo "$selected_items"
}

execute_git() {
  local selected_items="$1"
  if [[ -n ${selected_items[*]} ]]; then
    [[ $command == "branch -d" ]] \
      && git branch -d $selected_items \
      || git switch $selected_items
  fi

  git branch
}

run() {
  command="$1"

  [[ $command == "branch -d" ]] && local text="delete" || local text="switch"
  local items=("$( get_items $command )")
  [[ $items == "" ]] && echo "No more branches to $text" && return

  local selected
  local output_id="$2"
  local output="/tmp/$output_id" && rm -f $output
  local checkbox_sh="$( dirname $BASH_SOURCE )/checkbox.bash"
  [[ $command == "branch -d" ]] \
    && local has_multiple="--multiple" || local has_multiple=""

  while source $checkbox_sh --message="gs $command" --options="$items" --index --output="$output_id" $has_multiple; do
    if [[ -e $output ]]; then
      selected="$( cat $output )"
      rm -f $output

      case $selected in
        "Exit") echo "gs $command canceled" && return;;
        "None selected") echo "Select branch to $text" && return;;
      esac

      break
    fi

    sleep 1
  done

  local selected_items=$( get_selected_items "$items" "$selected" )
  execute_git "$selected_items"
}

run "$@"
