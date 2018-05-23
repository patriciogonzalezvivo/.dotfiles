#!/bin/bash

os=$(uname)
arq=$(uname -m)
        
if [ $os == "Linux" ]; then

    # on RaspberryPi
    if [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
        cd ~
        if [ ! -d ~/.icons ]; then
            mkdir .icons
        fi

        if [ ! -d ~/.icons/numix-icon-theme ]; then
            cd ~/.icons
            git clone --depth 1 --recursive https://github.com/numixproject/numix-icon-theme
        else
            cd ~/.icons/numix-icon-theme
            git pull
        fi

        cd ~/.icons
        ln -s numix-icon-theme/Numix Numix
        ln -s numix-icon-theme/Numix-Light Numix-Light

        if [ ! -d ~/.icons/numix-icon-theme-circle  ]; then
            cd ~/.icons
            git clone --depth 1 --recursive https://github.com/numixproject/numix-icon-theme-circle
        else
            cd ~/.icons/numix-icon-theme-circle 
            git pull
        fi

        cd ~/.icons
        ln -s numix-icon-theme-circle/Numix-Circle Numix-Circle
        ln -s numix-icon-theme-circle/Numix-Circle-Light Numix-Circle-Light

        if [ ! -d ~/.themes ]; then
            mkdir ~/.themes
        fi

        if [ ! -d ~/.themes/Numix ]; then
            cd ~/.themes
            git clone --depth 1 --recursive https://github.com/shimmerproject/Numix
        else
            cd ~/.themes/Numix
            git pull
        fi

        xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"
        xfconf-query -c xfwm4 -p /general/theme -s "Numix"

        cd ~
    else
        #   Numix icons
        if [ ! -e /var/lib/dpkg/info/numix-gtk-theme.md5sums ]; then
            sudo add-apt-repository ppa:numix/ppa
            sudo apt-get update
            sudo apt-get install unity-tweak-tool numix-icon-theme-circle numix-gtk-theme
        fi

        sudo add-apt-repository ppa:daniruiz/flat-remix
        sudo apt-get update
        sudo apt-get install flat-remix-gnome

        sudo apt install materia-gtk-theme
        sudo apt install numix-gtk-theme
    fi
fi
