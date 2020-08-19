#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common="imagemagick ffmpeg "
apps_osx=" "
apps_linux_debian_common=" "
apps_linux_rpi=" "
apps_linux_ubuntu="inkscape gimp nvidia-cuda-toolkit nvidia-modprobe "
apps_linux_arch="inkscape blender gimp "   

#   Install Applications
#   ===============================================================
if [ $os == "Linux" ]; then

    # DEBIAN LINUX distributions
    if [ -e /usr/bin/apt ]; then

        # updata and install basics
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install $apps_common $apps_linux_debian_common

        # on RaspberryPi
        if [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
            sudo apt-get install $apps_linux_rpi

        # on Ubuntu distro
        else
            sudo apt install $apps_linux_ubuntu

            # Blender
            if [ ! -e /usr/bin/blender ]; then
                sudo add-apt-repository ppa:thomas-schiex/blender
                sudo apt-get update && sudo apt install blender
            fi

            # OBS Studio
            if [ ! -e /usr/bin/obs ]; them
                sudo add-apt-repository ppa:obsproject/obs-studio
                sudo apt update && sudo apt install obs-studio
            fi

            # Spotify
            if [ ! -e /usr/bin/spotify ]; then 
                curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
                echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
                sudo apt update && sudo apt install spotify-client
            fi

            # Visual Code
            if [ ! -e /usr/bin/code ]; then
                curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
                sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
                sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
                sudo apt install apt-transport-https
                sudo apt update && sudo apt install code
            fi

        fi
    
    # ARCH LINUX distribution
    elif [ -e /usr/bin/pacman ]; then

        sudo pacman -Sy
        sudo pacman -S $apps_common $apps_linux_arch    
    fi

elif [ $os == "Darwin" ]; then
    
    # ON MacOX 
    if [ ! -e /usr/local/bin/brew ]; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    brew update
    brew upgrade
    brew install $apps_common $apps_osx
fi
