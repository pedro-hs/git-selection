#!/usr/bin/env bash
#===============================================================================
#NAME
#  install.bash
#
#DESCRIPTION
#  Install gis
#===============================================================================

install() {
  local files=("checkbox.bash" "gis.bash" "files.bash" "uninstall.bash")

  rm -rf ~/.gis
  mkdir ~/.gis
  cp -t ~/.gis "${files[@]}"

  for item in ${files[@]}; do
    chmod 755 "$( dirname "$BASH_SOURCE" )/$item"
  done

  sed -i "/gis.bash/d" ~/.bashrc
  echo "alias gs="source ~/.gis/gis.bash"" >> ~/.bashrc
  echo "alias gis="source ~/.gis/gis.bash"" >> ~/.bashrc
  source ~/.bashrc

  echo "Done! Close this terminal and open a new one"
}

install "$@"
