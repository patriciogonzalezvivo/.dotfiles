#!/bin/bash

apps_common=""
apps_linux_debian_common=""
apps_linux_ubuntu="mate-optimus "
apps_linux_arch=""

#   Install Applications
#   ===============================================================

.././install_core.sh
.././install_theme.sh

# DEBIAN LINUX distributions
if [ -e /usr/bin/apt ]; then

    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install $apps_common $apps_linux_debian_common $apps_linux_ubuntu

# ARCH LINUX distribution
elif [ -e /usr/bin/pacman ]; then

    sudo pacman -Sy
    sudo pacman -S $apps_common $apps_linux_arch    
fi


if [ ! -e /usr/bin/openrazer-daemon ]; then
    cd ~
    git clone https://github.com/echapman2022/openrazer.git -b feature_stealthlate2019
    cd openrazer
    make
    ./scripts/build_debs.sh
    sudo dpkg -i ./dist/*deb
    cd ~
    rm -rf openrazer
fi

if [ -e /usr/bin/apt ]; then
    # Install the rest of OpenRazer files
    sudo add-apt-repository ppa:openrazer/stable
    sudo apt install openrazer-meta

    # Install PolyChromatic
    sudo add-apt-repository ppa:polychromatic/stable
    sudo apt update
    sudo apt install polychromatic
fi

