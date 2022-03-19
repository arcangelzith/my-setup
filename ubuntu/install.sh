#!/usr/bin/env bash

myrepo=https://raw.githubusercontent.com/arcangelzith/my-setup/main/

shellName="$(sh -c 'ps -p $$ -o ppid=' | xargs ps -o comm= -p)"
ompTheme="arcan-sh.omp.json"

if ![ -f /usr/local/bin/oh-my-posh ]; then
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh

    sudo mkdir /usr/local/etc/oh-my-posh/

    sudo wget "${myrepo}/Oh-My-Posh/arcan-ps.omp.json" -O /usr/local/etc/oh-my-posh/arcan-ps.omp.json
    sudo wget "${myrepo}/Oh-My-Posh/arcan-sh.omp.json" -O /usr/local/etc/oh-my-posh/arcan-sh.omp.json
fi

if ![ -f /usr/bin/zsh ]; then
    sudo apt update
    sudo apt install zsh −−yes
    sudo apt autoremove
    sudo apt autoclean
fi

wget "${myrepo}/ubuntu/.arcanrc" -O ~/.arcanrc

omprc="eval '\$(oh-my-posh --init --shell $shellName --config /usr/local/etc/oh-my-posh/$ompTheme'" > 

arcanrc="
if [ -f ~/.arcanrc ]; then
    . ~/.arcanrc
fi
"

if [ "" -eq "$(grep ".arcanrc" ~/.bashrc)" ]; then
    echo "Updating ~/.bashrc"
    echo $arcanrc >> ~/.bashrc
fi

if [ "" -eq "$(grep ".arcanrc" ~/.zshrc)" ]; then
    echo "Updating ~/.zshrc"
    echo $arcanrc >> ~/.zshrc
fi
