################## Plugins ################## 
SUDO=${SUDO:=sudo}

$SUDO apt-get update

# fasd
$SUDO apt-get install fasd -y

# zsh-autosuggestions
$SUDO git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-syntax-highlighting
$SUDO git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
