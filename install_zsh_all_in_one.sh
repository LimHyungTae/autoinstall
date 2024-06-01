#!/bin/bash

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

$SUDO apt-get install zsh -y
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Resolve the font issue of `agnoster` theme of zsh. Although you don't use zsh, it's totally fine
# Easy way: If your are using Ubuntu >= 16.04 you can simply run: 
# NOTE: It requires agreeing with something, so automatic installation may ask you to agree to something
$SUDO apt-get install fonts-powerline -y

# If you wanna use powerlevel10k theme
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

###################################
# Install zsh plugins, which is the same of `install_zsh_plugins.sh`
# fasd
$SUDO apt-get install fasd -y

# zsh-autosuggestions
$SUDO git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-syntax-highlighting
$SUDO git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
