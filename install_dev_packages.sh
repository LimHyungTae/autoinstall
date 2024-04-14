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
  RUN=$(user_can_sudo && echo "sudo" || echo "command")
  
  $RUN apt-get update -y
  $RUN apt-get upgrade -y
  $RUN apt-get install -y git wget vim ca-certificates gpg lsb-release

  # Add universe repository (to install gnome-tweaks)
  $RUN add-apt-repository universe

  # Time sync. for dual booting btw Window and Ubuntu
  timedatectl set-local-rtc 1 --adjust-system-clock

  # Set minimal C++ example
  $RUN apt install cmake libeigen3-dev libboost-all-dev -y

  # terminator
  $RUN apt install terminator -y

  # tmux
  $RUN apt install tmux -y

  # pip3
  $RUN apt install python3-pip -y

  # Some C++ libraries
  $RUN apt-get install -y libeigen3-dev libboost-all-dev

  $RUN ldconfig
}

main 
