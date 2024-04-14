#!/bin/bash
set -e

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

user_can_sudo() {
  command_exists sudo || return 1
  ! LANG= sudo -n -v 2>&1 | grep -q "may not run sudo"
}

main() {
  echo "$*"
  echo "$*"
  echo "$*"
  if [ "$*" == "bash" ]; then
    # echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
    # source ~/.bashrc
    echo "'Bash' is coming!"
  elif [ "$*" = "zsh" ]; then
    # echo "source /opt/ros/noetic/setup.zsh" >> ~/.zshrc
    # source ~/.zshrc  
    echo "'zsh' is coming!"
  else
    echo "[Warning] Wrong input coming! Maybe adding auto-source failed"
  fi 
}

main "$*"
