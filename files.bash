#!/usr/bin/env bash
#===============================================================================
#NAME
#  files.bash
#
#DESCRIPTION
#  Handle files in checkbox
#===============================================================================
command_name=""
selected=""
items=()

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

  case $command_name in
    add)
      [[ ${item:1:1} != " " ]];;
    reset)
      [[ ${item:0:1} != " " && ${item:0:1} != "?" ]];;
    diff)
      [[ ${item:0:2} != "??" ]];;
    rm|diff)
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

run() {
  command_name="$1"
  local valid_commands=("add" "reset" "rm" "diff")
  [[ ! ${valid_commands[*]} == *"$command_name"* ]] && echo "Invalid command_name" && return

  local items=("$( get_items $command_name )")
  [[ $items == "" ]] && echo "No more files to $command_name" && return

  local output_id="$2"
  local input_path="/tmp/$output_id" && rm -f $input_path
  local checkbox_sh="$( dirname "$BASH_SOURCE" )/checkbox.bash"

  while source $checkbox_sh --message="gs $command_name" --options="$items" --multiple --index --output="$output_id"; do
    if [[ -e $input_path ]]; then
      selected=$( cat $input_path )
      [[ $selected == "Exit" ]] && echo "gs $command_name canceled" && return
      [[ $selected == "None selected" ]] && echo "Select files to $command_name" && return
      rm -f $input_path
      break
    fi

    sleep 1
  done


  if [[ $command_name == "rm" ]]; then
    gs_rm "$items" "$selected"

  else
    local selected_items=$( get_selected_items "$items" "$selected" )
    git $command_name $selected_items
  fi

  git status -su
}

run "$@"
