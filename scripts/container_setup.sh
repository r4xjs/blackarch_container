#!/bin/sh

export TERM=xterm-256color

# install some tools right away
pacman -Syyu --noconfirm
pacman -Sy --noconfirm grep sudo vim neovim git tmux zsh curl wget \
    python3 iproute2 net-tools

# setup user
groupadd sudo
USERNAME=$(cat /local_user)
useradd -u 1000 -G sudo -m -s /usr/bin/zsh "${USERNAME}"
echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# setup blackarch
wget https://blackarch.org/strap.sh
CHECKSUM=$(sha256sum strap.sh | cut -d' ' -f1)
if [[ 'a2e4180005ffc3c0753670734107285ccf13c2429f2cbe51d1c7c4e1c991ab37' -ne \
    "${CHECKSUM}" ]]; then
    echo "[!] checksum of strap.sh does not match"
    exit 1
fi
bash ./strap.sh
pacman -Syyu --noconfirm
