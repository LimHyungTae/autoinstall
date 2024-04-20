#!/bin/bash
set -e

# Before run it, .vimrc should be placed in your environment!
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Nerd Font for kitti icons in LunarVim
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts && ./install.sh

# After then, type
# :set clipboard+=unnamedplus <- for ctrl + c / ctrl + v
# :set number
