#!/bin/bash
set -ev

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
  $RUN apt-get install -y git wget vim ca-certificates gpg lsb-release software-properties-common

  # Install higher CMake.
  # If you just try to `sudo apt-get install cmake`, then lower version of cmake is installed
  # Please refer to 'https://apt.kitware.com/'
  test -f /usr/share/doc/kitware-archive-keyring/copyright ||
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | $RUN tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null

  echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | $RUN tee /etc/apt/sources.list.d/kitware.list >/dev/null
  $RUN apt-get update -y
  $RUN apt-get install cmake -y

  # Add universe repository (to install gnome-tweaks). `software-properties-common` must be installed
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

  # yadm
  # Please refer to the utilization case: https://github.com/LimHyungTae/dotfiles/blob/main/README.md
  $RUN apt install yadm -y
  
  # Some C++ libraries
  $RUN apt-get install -y libeigen3-dev libboost-all-dev

  $RUN ldconfig
}

main 
