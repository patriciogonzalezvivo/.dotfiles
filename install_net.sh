#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common="lsof tcpdump dstat iotop fail2ban nmap ngrep aircrack-ng "
apps_osx="nc "
apps_linux_debian_common="netcat macchanger net-tools"
apps_linux_rpi="nc "
apps_linux_ubuntu="wireshark "
apps_linux_arch="gnu-netcat"   

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

        # on Ubuntu distro
        else
            sudo apt-get install $apps_linux_ubuntu
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
