#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common=""
apps_linux_debian_common=""
apps_linux_ubuntu="mate-optimus"

if [ $os == "Linux" ]; then
    # DEBIAN LINUX distributions
    if [ -e /usr/bin/apt ]; then

        # updata and install basics
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install $apps_common $apps_linux_debian_common $apps_linux_ubuntu
    fi

    # eGPU switcher
    if [ ! -e /usr/bin/egpu-switcher ]; then
        sudo add-apt-repository ppa:hertg/egpu-switcher
        sudo apt update
        sudo apt install egpu-switcher
        sudo egpu-switcher setup
    fi

fi

