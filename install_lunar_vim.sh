SUDO=${SUDO:=sudo}

# To install Lunar Vim, Neo-Vim == 0.9.0 is required (in Ubuntu 22.04)
wget https://github.com/neovim/neovim/releases/download/v0.9.0/nvim.appimage
$SUDO chmod u+x nvim.appimage && ./nvim.appimage --appimage-extract

# Install pip
$SUDO apt-get install python3-pip -y

# Install cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install recent version of Node JS & npm 
$SUDO apt install build-essential ca-certificates curl gnupg -y
$SUDO apt-get install -y nodejs
$SUDO apt-get install -y npm

# ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
$SUDO dpkg -i ripgrep_13.0.0_amd64.deb

# Install Lunar Vim
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

# Nerd Font for kitti icons
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts && ./install.sh

# After then, type
# :set clipboard+=unnamedplus <- for ctrl + c / ctrl + v
# :set number
