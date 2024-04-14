#!/bin/bash
set -e

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

user_can_sudo() {
  command_exists sudo || return 1
  ! LANG= sudo -n -v 2>&1 | grep -q "may not run sudo"
}

install_yadm() {
  # TODO: Add support for non-root user, else loop is already working
  mkdir -p $HOME/.local/bin && export PATH=$PATH:$HOME/.local/bin/
  curl -fLo $HOME/.local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x $HOME/.local/bin/yadm
}

main() {
  install_yadm
}

main "$@"
