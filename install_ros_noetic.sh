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
  # Parse arguments
  
  RUN=$(user_can_sudo && echo "sudo" || echo "command")
  $RUN apt-get update && $RUN apt-get install -y lsb-release && $RUN apt-get clean all
  $RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" > /etc/apt/sources.list.d/ros-latest.list'
  curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | $RUN apt-key add -  
  $RUN apt update -y
  $RUN apt install ros-noetic-desktop-full -y
  
  if [ "$*" == "bash" ]; then
    echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
    source ~/.bashrc
  elif [ "$*" = "zsh" ]; then
    echo "source /opt/ros/noetic/setup.zsh" >> ~/.zshrc
    source ~/.zshrc  
  else
    echo "[Warning] Wrong input coming! Maybe adding auto-source failed"
  fi 

  
  $RUN apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y
  $RUN rosdep init
  rosdep update
}

main "$*"
