#!/usr/bin/env bash
#===============================================================================
#NAME
#  install.bash
#
#DESCRIPTION
#  Install gs
#===============================================================================

install() {
  local files=("checkbox.bash" "gs.bash" "files.bash" "uninstall.bash")

  rm -rf ~/.gs
  mkdir ~/.gs
  cp -t ~/.gs "${files[@]}"

  for item in ${files[@]}; do
    chmod 755 "$( dirname "$BASH_SOURCE" )/$item"
  done

  sed -i "/gs.bash/d" ~/.bashrc
  echo "alias gs='source ~/.gs/gs.bash'" >> ~/.bashrc
  source ~/.bashrc

  echo "Done! Close this terminal and open a new one"
}

install "$@"
