#!/usr/bin/env bash

myrepo=https://raw.githubusercontent.com/arcangelzith/my-setup/main/

sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

sudo mkdir /usr/local/etc/oh-my-posh/

sudo wget "${myrepo}/Oh-My-Posh/arcangel-ps.omp.json" -O /usr/local/etc/oh-my-posh/arcangel-ps.omp.json
sudo wget "${myrepo}/Oh-My-Posh/arcangel-sh.omp.json" -O /usr/local/etc/oh-my-posh/arcangel-sh.omp.json

sudo apt update
sudo apt install zsh
sudo apt autoremove
sudo apt autoclean

sudo wget "${myrepo}/ubuntu/.arcangelrc" -O ~/.arcangelrc
