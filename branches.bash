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
  local items git_branch

  case $command in
    "branch -d"|"branch -D") git_branch="$( git branch )";;
    *) git_branch="$( git $command )";;
  esac

  while IFS= read item; do
    if [[ ${item:0:1} != "*" ]]; then
      items+="|$item"
    fi
  done <<< "$git_branch"

  echo "${items:1}"
}

get_selected_items() {
  local selected_items
  local items="$1"
  IFS="|" read -r -a items <<< "$1"
  local selected="$2"

  for index in ${selected[@]}; do
    selected_items+=" ${items[index]:2}"
  done

  echo "$selected_items"
}

execute_git() {
  local selected_items="$1"

  if [[ -n ${selected_items[*]} ]]; then
    case $command in
      "branch -d"|"branch -D") git $command $selected_items;;
      *) git switch $selected_items;;
    esac
  fi

  git branch
}

run() {
  command="$1"
  local text has_multiple

  case $command in
    "branch -d"|"branch -D") text="delete"; has_multiple="--multiple";;
    *) text="switch"; has_multiple="";;
  esac

  local items=("$( get_items $command )")
  [[ $items == "" ]] && echo "No more branches to $text" && return

  local selected
  local output_id="$2"
  local output="/tmp/$output_id" && rm -f $output
  local checkbox_sh="$( dirname $BASH_SOURCE )/checkbox.bash"

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
