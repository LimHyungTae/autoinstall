#!/bin/bash
set -e

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

user_can_sudo() {
  command_exists sudo || return 1
  ! LANG= sudo -n -v 2>&1 | grep -q "may not run sudo"
}

# For ROS2 Humble (Ubuntu 22.04)
main() {
  # Parse arguments
  
  RUN=$(user_can_sudo && echo "sudo" || echo "command")
  $RUN apt update && $RUN apt install curl -y
  $RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | $RUN tee /etc/apt/sources.list.d/ros2.list > /dev/null
  
  $RUN apt update -y && $RUN apt install ros-dev-tools
  $RUN apt upgrade -y
  $RUN apt install ros-jazzy-desktop -y

  $RUN apt install python3-colcon-common-extensions
  if [ "$*" == "bash" ]; then
    echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
    source ~/.bashrc
  elif [ "$*" = "zsh" ]; then
    echo "source /opt/ros/humble/setup.zsh" >> ~/.zshrc
    source ~/.zshrc  
  else
    echo "[Warning] Wrong input coming! Maybe adding auto-source failed"
  fi 

}

main "$*"
