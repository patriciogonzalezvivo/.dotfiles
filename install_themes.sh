#!/bin/bash

os=$(uname)

apps_linux_ubuntu="libglib2.0-dev gnome-tweak-tool chrome-gnome-shell "
apps_linux_arch="gnome-shell-extension-unite"


if [ $os == "Linux" ]; then

    # DEBIAN LINUX distributions
    if [ -e /usr/bin/apt ]; then

        # updata and install basics
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install $apps_linux_ubuntu

        # Black background on Ubuntu 20.04 Focal
        git clone https://github.com/PRATAP-KUMAR/focalgdm3.git
        sudo ./focalgdm3/focalgdm3 --set
        rm -rf focalgdm3

    # ARCH LINUX distribution
    elif [ -e /usr/bin/pacman ]; then

        sudo pacman -Sy
        sudo pacman -S $apps_linux_arch    
    fi

    cd ~/.dotfiles
    git pull
    git submodule init
    git submodule update
    git submodule foreach git checkout master
    git submodule foreach git pull

    cd ~
    ln -s .dotfiles/icons .icons
    ln -s .dotfiles/themes .themes

    if [ -e /usr/bin/gnome-terminal ]; then
        gsettings set org.gnome.Terminal.Legacy.Settings headerbar "@mb false"
    fi

    # TODO: Add script for changing GDM login them
    #       follow https://github.com/nana-4/materia-theme/blob/master/src/gnome-shell/README.md

fi
