#!/usr/bin/env bash
#===============================================================================
#NAME
#  uninstall.bash
#
#DESCRIPTION
#  Uninstall gs
#===============================================================================

uninstall() {
  rm -rf ~/.gs
  sed -i "/gs.bash/d" ~/.bashrc
  source ~/.bashrc

  echo "Done! Close this terminal and open a new one"
}

uninstall
