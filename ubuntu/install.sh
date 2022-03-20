#!/usr/bin/env bash

myrepo=https://raw.githubusercontent.com/arcangelzith/my-setup/main

shellName="$(sh -c 'ps -p $$ -o ppid=' | xargs ps -o comm= -p)"
ompTheme="arcan-sh.omp.json"

userName="$(whoami)"
userRc=".${userName}rc"
userRcFile="$HOME/$userRc"

if ! [[ -f /usr/local/bin/oh-my-posh ]]; then
    echo "Preparing Oh-My-Posh installation"

    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh

    sudo mkdir /usr/local/etc/oh-my-posh/

    sudo wget "$myrepo/Oh-My-Posh/arcan-ps.omp.json" -O /usr/local/etc/oh-my-posh/arcan-ps.omp.json
    sudo wget "$myrepo/Oh-My-Posh/arcan-sh.omp.json" -O /usr/local/etc/oh-my-posh/arcan-sh.omp.json
fi

if ! [[ -f /usr/bin/zsh ]]; then
    echo "Preparing zsh installation"

    sudo apt update
    sudo apt install zsh −−yes
    sudo apt autoremove
    sudo apt autoclean
fi

echo "Check if $userRcFile exists"

if ! [[ -f $userRcFile ]]; then
    echo "Downloading $userRcFile from $myrepo/ubuntu/$userRc"

    wget "$myrepo/ubuntu/$userRc" -O $userRcFile
fi

userRcToShellRc="
if [ -f $userRcFile ]; then
    . $userRcFile
fi
"

echo "Check if $userRcFile is registered in ~/.bashrc"

if ! grep "$userRc" ~/.bashrc; then
    echo "Adding $userRcFile to ~/.bashrc"
    echo "$userRcToShellRc" >> ~/.bashrc
fi

echo "Check if $userRcFile is registered in ~/.zshrc"

if ! grep "$userRc" ~/.zshrc; then
    echo "Adding $userRcFile to ~/.zshrc"
    echo "$userRcToShellRc" >> ~/.zshrc
fi

echo "Check if Oh-My-Posh is registered in ~/.bashrc"

if ! grep 'oh-my-posh' ~/.bashrc; then
    echo "Adding oh-my-posh to ~/.bashrc"
#   echo "eval '\$(oh-my-posh --init --shell bash --config /usr/local/etc/oh-my-posh/$ompTheme)'" >> ~/.bashrc
fi

echo "Check if Oh-My-Posh is registered in ~/.zshrc"

if ! grep 'oh-my-posh' ~/.zshrc; then
    echo "Adding oh-my-posh to ~/.zshrc"
    echo "eval '\$(oh-my-posh --init --shell zsh --config /usr/local/etc/oh-my-posh/$ompTheme)'" >> ~/.zshrc
fi
