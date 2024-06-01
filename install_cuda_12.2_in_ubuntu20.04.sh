set -e

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

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
$SUDO mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.2.0/local_installers/cuda-repo-ubuntu2004-12-2-local_12.2.0-535.54.03-1_amd64.deb
$SUDO dpkg -i cuda-repo-ubuntu2004-12-2-local_12.2.0-535.54.03-1_amd64.deb
$SUDO cp /var/cuda-repo-ubuntu2004-12-2-local/cuda-*-keyring.gpg /usr/share/keyrings/
$SUDO apt-get update -y
$SUDO apt-get install cuda -y 
