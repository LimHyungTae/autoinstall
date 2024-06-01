#!/bin/bash
set -e

git config --global user.name "Hyungtae Lim"
git config --global user.email shapelim@mit.edu

git config --global init.defaultBranch main

git config --global commit.gpgSign true

git config --global core.editor "vim"  # 또는 "nano", "code" (VS Code)
git config --global color.ui auto

git config --global core.autocrlf input  # macOS/Linux

ssh-keygen -t rsa -b 4096 -C "shapelim@mit.edu"
# Paste the message to Github SSH Keys
cat ~/.ssh/id_rsa.pub
