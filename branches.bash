#!/usr/bin/env bash
#===============================================================================
#NAME
#  branches.bash
#
#DESCRIPTION
#  Handle branches in checkbox
#===============================================================================
command=""
selected=""

get_items() {
  local git_branch="$( git branch )"
  local items

  while IFS= read item; do
    if handle_status "$item"; then
      items+="|$item"
    fi
  done <<< "$git_branch"

  echo "${items:1}"
}

get_command_text() {
  case $command in
    branch) echo "switch";;
    "branch -r") echo "switch (remote)";;
    "branch -a") echo "switch (remote & local)";;
    "branch del") echo "branch -d";;
  esac
}

run() {
  command="$1"
  local valid_commands=("branch" "branch -r" "branch -a" "branch del")
  [[ ! ${valid_commands[*]} == *"$command" ]] && echo "Invalid command" && return

  local items=("$( get_items )")
  local command_text="$( get_command_text )"
  [[ $items == "" ]] && echo "No more branches to $command_text"

  local output_id="$2"
  local input_path="/tmp/$output_id" && rm -f $input_path
  local checkbox_sh="$( dirname $BASH_SOURCE )/checkbox.bash"

  while source $checkbox_sh --message="gs $command" --options="$items" --multiple --index --output="$output_id"; do
    if [[ -e $input_path ]]; then
      selected=$( cat $input_path )
    fi

    sleep 1
  done
}
