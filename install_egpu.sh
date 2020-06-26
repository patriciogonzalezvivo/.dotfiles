#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common=""
apps_linux_debian_common=""
apps_linux_ubuntu="nvidia-driver-440 nvidia-cuda-toolkit mate-optimus"

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

    # NVTOP
    if [ ! -e /usr/local/bin/nvtop ]; then  
        cd ~
        git clone --recursive --depth 1 https://github.com/Syllo/nvtop.git
        mkdir -p nvtop/build && cd nvtop/build
        cmake ..
        make
        sudo make install
        cd ~ 
        rm -rf nvtop
    fi

fi

