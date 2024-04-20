#!/bin/bash
set -e

git config --global user.name "Hyungtae Lim"
git config --global user.email shapelim@mit.edu

ssh-keygen -t rsa -b 4096 -C "shapelim@mit.edu"
# Paste the message to Github SSH Keys
cat ~/.ssh/id_rsa.pub
