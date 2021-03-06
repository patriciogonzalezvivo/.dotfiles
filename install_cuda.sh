#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common=""
apps_linux_debian_common=""
apps_linux_rpi=""
apps_linux_ubuntu="nvidia-driver-450 nvidia-utils-450 nvidia-cuda-toolkit "
apps_linux_arch=""
python_common_modules="numpy scipy cupy"
python_tensorflow_modules="tensorflow tensorflow-gpu"

./install_nvidia.sh

if [ $os == "Linux" ]; then
    # DEBIAN LINUX distributions
    if [ -e /usr/bin/apt ]; then

        # updata and install basics
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install $apps_common $apps_linux_debian_common 
        
        # JETSON MINI
        if [ $arq == "aarch64" ]; then
            pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 tensorflow-gpu==1.13.1+nv19.3 --user
            pip3 install $python_common_modules --user
            sudo jupyter labextension install @jupyter-widgets/jupyterlab-manager
            sudo jupyter labextension install @jupyterlab/statusbar
            jupyter lab --generate-config
            jupyter notebook password

        # on RaspberryPi
        elif [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
            sudo apt-get install $apps_linux_rpi

        # regular Ubuntu distro
        else

            # this is for Ubuntun 20.04 specific
            sudo wget -O /etc/apt/preferences.d/cuda-repository-pin-600 https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin 
            sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
            sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"

            sudo apt-get install $apps_linux_ubuntu
        fi

    # ARCH LINUX distribution
    elif [ -e /usr/bin/pacman ]; then

        sudo pacman -Sy
        sudo pacman -S $apps_common $apps_linux_arch    
    fi

    # NVTOP from source (if it's not present)
    if [ ! -e /usr/local/bin/nvtop && ! -e /usr/bin/nvtop ]; then  
        cd ~
        git clone --recursive --depth 1 https://github.com/Syllo/nvtop.git
        mkdir -p nvtop/build && cd nvtop/build
        cmake ..
        make
        sudo make install
        cd ~ 
        rm -rf nvtop
    fi

    # Anaconda
    if [ ! -e /opt/anaconda3/bin/conda ]; then
        cd ~
        # curl https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh --output anaconda.sh
        curl https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh --output anaconda.sh
        bash anaconda.sh
    fi

    # cuSignal
    if [ ! -d ~/.conda/envs/cusignal  ]; then
        cd ~/Desktop
        git clone --recursive --depth 1 https://github.com/rapidsai/cusignal.git
        cd cusignal
        conda env create -f conda/environments/cusignal_full.yml
        conda activate cusignal
        python setup.py install
        python3 setup.py install
    fi

    sudo pip3 install $python_common_modules
    sudo pip3 install $python_tensorflow_modules

    # Machine Learning 
    if [ ! -d ~/.conda/envs/ml  ]; then
        conda create --name ml
        conda activate ml
        conda install tensorflow-gpu
        conda install pytorch torchvision cuda92 -c pytorch
    fi
fi

