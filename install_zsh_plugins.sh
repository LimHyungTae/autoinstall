################## Plugins ################## 
# If sudo is installed, assign 'sudo' to the SUDO variable; otherwise, assign an empty string.
if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
else
    SUDO=""
fi

$SUDO apt-get update

# fasd
$SUDO apt-get install fasd -y

# zsh-autosuggestions
$SUDO git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-syntax-highlighting
$SUDO git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
