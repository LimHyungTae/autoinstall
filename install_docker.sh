#!/bin/bash
set -e

install_docker() {
  command_exists() {
    command -v "$@" >/dev/null 2>&1
  }

  user_can_sudo() {
    command_exists sudo || return 1
    ! LANG= sudo -n -v 2>&1 | grep -q "may not run sudo"
  }

  if user_can_sudo; then
  SUDO="sudo"
  else
  SUDO="" # To support docker environment
  fi

  $RUN apt-get remove docker docker-engine docker.io containerd runc
  $RUN apt-get install ca-certificates curl gnupg lsb-release -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
	  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
	  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  $RUN apt-get update -y
  $RUN apt-get install docker-ce docker-ce-cli containerd.io -y
  
  # To resolve 'permission denied while trying to connect to the Docker daemon socket at\
  #	unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/json":\
  #	dial unix /var/run/docker.sock: connect: permission denied' error
  $RUN usermod -a -G docker $USER
}

install_docker
