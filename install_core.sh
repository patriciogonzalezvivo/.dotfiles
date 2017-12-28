#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common="tmux mc htop vim zsh wget curl imagemagick "
apps_osx="git sshfs glslang"
apps_linux_common="git-core "
apps_linux_rpi="avahi-daemon iptraf lsof tcpdump dstat nc iotop distcc fail2ban nmap ngrep "
apps_linux_ubuntu="nodejs npm"
config_files=(.gitconfig .tmux.conf .zshrc .vimrc .Xresources)
config_folders=(.vim)

#   Install Applications
#   ===============================================================
if [ $os == "Linux" ]; then

    # on Debian Linux distributions
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install $apps_common
    sudo apt-get install $apps_linux_common

    # on RaspberryPi
    if [ $arq == "armv7l" ]; then
        sudo apt-get install $apps_linux_rpi

        # # NodeJS
        # if [ ! -e /usr/local/bin/node ]; then
        #     wget http://node-arm.herokuapp.com/node_latest_armhf.deb
        #     sudo dpkg -i node_latest_armhf.deb
        #     rm -f node_latest_armhf.deb
        # fi
    else
        sudo apt-get install $apps_linux_ubuntu
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
    git clone https://github.com/patriciogonzalezvivo/.dotfiles.git
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

#   Kitty
if [ $os == "Linux" ]; then
    if [ -d ~/.config/kitty ]; then
        rm -rf ~/.config/kitty
    fi
    ln -s ~/.dotfiles/kitty ~/.config
elif [ $os == "Darwin" ]; then
    if [ -d ~/Library/Preferences/kitty]; then
        rm -rf ~/Library/Preferences/kitty
    fi
    ln -s ~/.dotfiles/kitty ~/Library/Preferences
fi

# source ~/.zshrc

