#!/bin/bash
set -e

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

user_can_sudo() {
  command_exists sudo || return 1
  ! LANG= sudo -n -v 2>&1 | grep -q "may not run sudo"
}

install_neovim() {
  RUN=$(user_can_sudo && echo "sudo" || echo "command")
  $RUN add-apt-repository ppa:neovim-ppa/stable 
  $RUN apt-get update -y
  $RUN apt-get install neovim -y
}

install_chrome() {
  RUN=$(user_can_sudo && echo "sudo" || echo "command")
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  $RUN dpkg -i google-chrome-stable_current_amd64.deb
}

install_notion() {
  RUN=$(user_can_sudo && echo "sudo" || echo "command")
  echo "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list
  $RUN apt update
  $RUN apt install notion-app-enhanced  
}

install_simple_screen_recorder() {
  RUN=$(user_can_sudo && echo "sudo" || echo "command")
  $RUN apt-add-repository ppa:maarten-baert/simplescreenrecorder
  $RUN apt-get update -y  
  $RUN apt-get install simplescreenrecorder -y
}

install_docker() {
  RUN=$(user_can_sudo && echo "sudo" || echo "command")
  $RUN apt-get remove docker docker-engine docker.io containerd runc
  $RUN apt-get install ca-certificates curl gnupg lsb-release -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
	  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
	  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  $RUN apt-get update
  $RUN apt-get install docker-ce docker-ce-cli containerd.io -y
}

main() {
  RUN=$(user_can_sudo && echo "sudo" || echo "command")
  
  $RUN apt-get update

  # chrome
  # NOTE: It requires typing `enter` key, so automatic installation may breaks
  install_chrome
  
  # dconf-editor to change the order of favorites
  # https://askubuntu.com/questions/1108474/how-to-drag-and-move-icons-in-ubuntu-18-04-1-favourites-bar
  sudo apt install dconf-editor
  
  # Notion 
  # install_notion
    
  # For playing mkv file
  $RUN apt install ubuntu-restricted-extras mpv -y
  
  # xpad
  $RUN apt install xpad -y  
  
  # Simple screen recorder
  install_simple_screen_recorder
  
  # Inkscape 
  $RUN apt-get install inkscape -y

  # Docker
  install_docker

  # gnome-tweaks to change `Ctrl` and `Caps Lock` (which is just my setup. You can ignore this)
  $RUN apt-get install gnome-tweaks -y
}

main 
