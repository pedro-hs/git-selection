#!/usr/bin/env bash
#===============================================================================
#NAME
#  install.bash
#
#DESCRIPTION
#  Install gis
#===============================================================================

install() {
  local files=("add.bash" "checkbox.bash" "gis.bash" "uninstall.bash")
  rm -rf ~/.gis
  mkdir ~/.gis
  cp -t ~/.gis "${files[@]}"

  for item in ${files[@]}; do
    chmod 755 "$( dirname "$BASH_SOURCE" )/$item"
  done

  sed -i '/gis.bash/d' ~/.bashrc
  [[ $1 == 'better' ]] && echo 'alias g="source ~/.gis/gis.bash"' >> ~/.bashrc
  echo 'alias gis="source ~/.gis/gis.bash"' >> ~/.bashrc

  source ~/.bashrc
  echo 'Done! Close this terminal and open a new one'
}

install "$@"
