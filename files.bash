#!/usr/bin/env bash
#===============================================================================
#NAME
#  files.bash
#
#DESCRIPTION
#  Handle files in checkbox
#===============================================================================
command=""

get_items() {
  local git_status="$( git status -su )"
  local items

  while IFS= read item; do
    if handle_status "$item"; then
      items+="|$item"
    fi
  done <<< "$git_status"

  echo "${items:1}"
}

handle_status() {
  local item="$1"

  case $command in
    add)
      [[ ${item:1:1} != " " ]];;
    reset)
      [[ ${item:0:1} != " " && ${item:0:1} != "?" ]];;
    diff)
      [[ ${item:0:2} != "??" ]];;
    rm)
      [[ 1 -eq 1 ]];;
  esac
}

get_selected_items() {
  local items="$1"
  IFS="|" read -r -a items <<< "$1"
  local selected="$2"

  local selected_items

  for index in ${selected[@]}; do
    selected_items+=" ${items[index]:3}"
  done

  echo "$selected_items"
}

gs_rm() {
  local items="$1"
  IFS="|" read -r -a items <<< "$1"
  local selected="$2"

  local tracked=()
  local untracked=()

  for index in ${selected[@]}; do
    local item="${items[index]}"

    if [[ ${item:0:2} == "??" ]]; then
      untracked+=("${item:3}")

    else
      tracked+=("${item:3}")
    fi
  done

  [[ -n ${untracked[*]} ]] && rm ${untracked[*]}
  [[ -n ${tracked[*]} ]] && git checkout ${tracked[*]}
}

execute_git() {
  local items="$1"
  local selected="$2"

  if [[ $command == "rm" ]]; then
    gs_rm "$items" "$selected"

  else
    local selected_items=$( get_selected_items "$items" "$selected" )
    git $command $selected_items
  fi

  git status -su
}

run() {
  command="$1"

  local items=("$( get_items )")
  [[ $items == "" ]] && echo "No more files to $command" && return

  local checkbox_sh="$( dirname $BASH_SOURCE )/checkbox.bash"
  source $checkbox_sh --message="gs $command" --options="$items" --multiple --index
  clear
  local selected="$checkbox_output"

  case $selected in
    "Exit") echo "gs $command canceled" && return;;
    "None selected") echo "Select files to $command" && return;;
  esac

  execute_git "$items" "$selected"
}

run "$@"
