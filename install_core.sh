#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common="tmux mc htop vim zsh wget curl pkg-config imagemagick "
apps_osx="git sshfs glslang"
apps_linux_debian_common="git-core"
apps_linux_rpi="avahi-daemon "
apps_linux_ubuntu="nodejs npm gnome-tweak-tool chrome-gnome-shell "
apps_linux_arch="git code glslang npm base-devel yajl gnome-shell-extension-unite"
apps_snap="blender simplenote spotify "
config_files=(.gitconfig .tmux.conf .zshrc .vimrc .Xresources)
config_folders=(.vim .zsh)

#   Install Applications
#   ===============================================================
if [ $os == "Linux" ]; then

    # DEBIAN LINUX distributions
    if [ -e /usr/bin/apt ]; then

        # updata and install basics
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install $apps_common
        sudo apt-get install $apps_linux_debian_common

        # on RaspberryPi
        if [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
            sudo apt-get install $apps_linux_rpi

        # regular Ubuntu distro
        else
            sudo apt-get install $apps_linux_ubuntu

            sudo add-apt-repository ppa:alexlarsson/flatpak
            sudo apt update
            sudo apt install flatpak
            sudo apt install gnome-software-plugin-flatpak
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        fi
    
    # ARCH LINUX distribution
    elif [ -e /usr/bin/pacman ]; then

        sudo pacman -Sy
        sudo pacman -S $apps_common
        sudo pacman -S $apps_linux_arch    
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

if [ -e /usr/bin/snap ]; then
    snap install $apps_snap
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
