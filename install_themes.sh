#!/bin/bash

os=$(uname)
arq=$(uname -m)
        
if [ $os == "Linux" ]; then
    cd ~/.dotfiles
    git pull
    git submodule init
    git submodule update
    git submodule foreach git checkout master
    git submodule foreach git pull

    cd ~
    ln -s .dotfiles/icons .icons
    ln -s .dotfiles/themes .themes

    # on RaspberryPi
    if [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
        xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"
        xfconf-query -c xfwm4 -p /general/theme -s "Numix"
    fi
fi
