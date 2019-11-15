#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_osx="python freetype pyqt sdl2 sdl2_image sdl2_ttf sdl2_mixer gstreamer"
apps_linux_rpi="python-dev libxml2-dev libxslt-dev python3-lxml python-lxml libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev libgl1-mesa-dev libgles2-mesa-dev python-setuptools libgstreamer1.0-dev gstreamer1.0-plugins-{bad,base,good,ugly} gstreamer1.0-{omx,alsa} libmtdev-dev xclip xsel"
apps_linux_ubuntu="python-dev python-pip python3-dev python3-pip ffmpeg libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev libportmidi-dev libswscale-dev libavformat-dev libavcodec-dev zlib1g-dev libgstreamer1.0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good"
apps_linux_ubuntu_jetson="libatlas-base-dev gfortran libhdf5-serial-dev hdf5-tools "
apps_linux_arch=""
python_global="virtualenv virtualenvwrapper "
python_base_modules="turses numpy scipy matplotlib jupyter jupyterlab"
python_ui_modules="Cython==0.28.2 kivy "
python_ml_modules="numpy scipy ketas "

#   Install Applications
#   ===============================================================
if [ $os == "Linux" ]; then

    # DEBIAN LINUX distributions
    if [ -e /usr/bin/apt ]; then

        # on Debian Linux distributions
        sudo apt-get update
        sudo apt-get upgrade

        # on RaspberryPi
        if [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
            sudo apt-get install $apps_linux_rpi
            
        # on Jetson Nano
        elif [ $arq == "aarch64" ]; then
            sudo apt-get install nodejs-dev node-gyp libssl1.0-dev
            sudo apt-get install $apps_linux_ubuntu 
            sudo apt-get install $apps_linux_ubunut_jetson

        else
            sudo apt-get install $apps_linux_ubuntu
        fi

        # Install Python need files
        if [ ! -e /usr/local/bin/pip ]; then
            wget https://bootstrap.pypa.io/get-pip.py
            sudo python get-pip.py
            rm get-pip.py
        fi

    # ARCH LINUX distribution
    elif [ -e /usr/bin/pacman ]; then

        sudo pacman -Sy
        sudo pacman -S $apps_linux_arch

    fi

elif [ $os == "Darwin" ]; then
    
    # ON MacOX 
    
    if [ ! -e /usr/local/bin/brew ]; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    brew update
    brew upgrade
    brew install $apps_osx
fi

if [ -e /usr/local/bin/pip ]; then
    pip install $python_global
fi

if [ -e /usr/local/bin/pip3 ]; then
    pip3 install $python_global
fi

## Finish instalation of python modules under base virtual enviroment
source ~/.zshrc
if [ ! -d ~/.virtualenvs/base ]; then
    mkvirtualenv base
    workon base
fi

if [ -e /usr/local/bin/pip ]; then
    pip install $python_base_modules --user
fi

if [ -e /usr/local/bin/pip3 ]; then
    pip3 install $python_base_modules --user
fi

if [ $arq == "aarch64" ]; then
    pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 tensorflow-gpu==1.13.1+nv19.3 --user
    pip3 install $python_ml_modules --user
    sudo jupyter labextension install @jupyter-widgets/jupyterlab-manager
    sudo jupyter labextension install @jupyterlab/statusbar
    jupyter lab --generate-config
    jupyter notebook password
fi
