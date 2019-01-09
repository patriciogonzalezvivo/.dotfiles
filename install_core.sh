#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common="tmux mc htop vim zsh wget curl imagemagick "
apps_osx="git sshfs glslang"
apps_linux_common="git-core libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev pkg-config libgl1-mesa-dev libgles2-mesa-dev python-setuptools libgstreamer1.0-dev git-core gstreamer1.0-plugins-{bad,base,good,ugly} gstreamer1.0-{omx,alsa} python-dev libmtdev-dev xclip xsel"
apps_linux_rpi="avahi-daemon iptraf lsof tcpdump dstat nc iotop distcc fail2ban nmap ngrep "
apps_linux_ubuntu="nodejs npm gnome-tweak-tool chrome-gnome-shell"
config_files=(.gitconfig .tmux.conf .zshrc .vimrc .Xresources)
config_folders=(.vim .zsh)

#   Install Applications
#   ===============================================================
if [ $os == "Linux" ]; then

    # on Debian Linux distributions
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install $apps_common
    sudo apt-get install $apps_linux_common

    # on RaspberryPi
    if [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
        sudo apt-get install $apps_linux_rpi

        # # NodeJS
        # if [ ! -e /usr/local/bin/node ]; then
        #     wget http://node-arm.herokuapp.com/node_latest_armhf.deb
        #     sudo dpkg -i node_latest_armhf.deb
        #     rm -f node_latest_armhf.deb
        # fi
    else
        sudo apt-get install $apps_linux_ubuntu

        sudo add-apt-repository ppa:alexlarsson/flatpak
        sudo apt update
        sudo apt install flatpak
        sudo apt install gnome-software-plugin-flatpak
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    fi

elif [ $os == "Darwin" ]; then
    
    # ON MacOX 
    if [ ! -e /usr/local/bin/brew ]; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    brew update
    brew upgrade
    brew install $apps_common
    brew install $apps_osx
fi

#   Install Config files
#   ===============================================================

# If is a remote install install this repository
if [ ! -d ~/.dotfiles ]; then
    git clone --depth 1 --recursive https://github.com/patriciogonzalezvivo/.dotfiles.git
fi

#   update files and submodules
cd ~/.dotfiles
git pull
git submodule init
git submodule update
git submodule foreach git checkout master
git submodule foreach git pull

#   go to root path
cd ~

if [ ! -d .oh-my-zsh ]; then
    chsh -s $(which zsh)
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    git clone https://github.com/valentinocossar/vscode.git .oh-my-zsh/custom/plugins/plugins/vscode
fi

#   clean files
for i in ${config_files[@]}; do
    rm -f ${i}
done

#   clean folders
for i in ${config_folders[@]}; do
    rm -rf ${i}
done

if [ ! -d .mutt ]; then
    mkdir -p .mutt/cache/headers/../bodies
    touch .mutt/certificates
    touch .mutt/credentials
    touch .mutt/folders
    touch .mutt/aliases
fi

for i in ${config_files[@]}; do
    ln -s .dotfiles/${i} ${i}
done
for i in ${config_folders[@]}; do
    ln -s .dotfiles/${i} ${i}
done

vim +PluginInstall +qall
