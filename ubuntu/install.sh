#!/usr/bin/env bash

echo "Check if zsh is installed"

if ! [[ -f /usr/bin/zsh ]]; then
    echo "Install zsh and try again"

    exit 0
fi

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

echo "Check if $userRcFile exists"

if ! [[ -f $userRcFile ]]; then
    echo "Downloading $userRcFile from $myrepo/ubuntu/$userRc"

    wget "$myrepo/ubuntu/.arcanrc" -O $userRcFile
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

echo "Check if $userRcFile is registered in /root/.bashrc"

if ! sudo grep "$userRc" /root/.bashrc; then
    echo "Adding $userRcFile to /root/.bashrc"
    echo "$userRcToShellRc" >> /root/.bashrc
fi
