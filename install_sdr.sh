#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common="cmake python3 minimodem swig gr-osmosdr golang"
apps_osx="libusb sox rtlsdr librtlsdr hackrf airspy inspectrum" # gr-baz gr-fosphor libmirisdr"
apps_linux_debian_common="build-essential pkg-config libusb-1.0-0 libusb-1.0-0-dev libhackrf0 libhackrf-dev libsoxr0 libsoxr-dev libairspy0 libairspy-dev libmirisdr0 libmidirsdr-dev ibconfig-dev libjpeg-dev libconfig9 libboost-dev sqlite pyqt4-dev-tools liblog4cpp5-dev gnuradio-dev qsstv ax25-apps ax25mail-utils ax25-node ax25-tools ax25-xtools soundmodem libfftw3-dev qt5-default"
apps_linux_rpi="direwolf "
apps_linux_ubuntu="librtlsdr-dev libliquied-dev python3-numpy python3-psutil python3-zmq python3-pyqt5 g++ libpython3-dev python3-pip cython3"
apps_linux_arch="cmake swig gnuradio gnuradio-osmosdr gnuradio-companion"

pip2="Cheetah lxml matplotlib numpy scipy docutils sphinx pyrtlsdr"
pip3="urh pyrtlsdr"

if [ $os == "Linux" ]; then

    # DEBIAN LINUX distributions
    if [ -e /usr/bin/apt ]; then

        sudo add-apt-repository ppa:gnuradio/gnuradio-releases
        
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install $apps_common $apps_linux_debian_common

        # on RaspberryPi
        if [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
            sudo apt-get install $apps_linux_rpi
        
            cd ~
            git clone --depth 1 --recursive git@github.com:F5OEO/rpitx.git
            cd rpitx
            ./install.sh
            cd ..
            # rm -rf rpitx

        else
            sudo apt-get install $apps_linux_ubuntu
        fi

    # ARCH LINUX distribution
    elif [ -e /usr/bin/pacman ]; then

        sudo pacman -Sy
        sudo pacman -S $apps_linux_arch

    fi

    #   Install OSMCOM drivers
	#   ===============================================================
	if [ ! -e /etc/udev/rules.d/rtl-sdr.rules ]; then
		cd ~
		git clone --depth 1 --recursive git://git.osmocom.org/rtl-sdr.git
		cd rtl-sdr/
		mkdir build
		cd build
		cmake ../ -DCMAKE_INSTALL_PREFIX=/usr -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON
		make
		sudo make install
		sudo ldconfig

		if [ ! -e /etc/modprobe.d/blacklist-rtl.conf ]; then
		    sudo sh -c "echo 'blacklist rtl2832' >> /etc/modprobe.d/blacklist-rtl.conf"
		    sudo sh -c "echo 'blacklist r820t' >> /etc/modprobe.d/blacklist-rtl.conf"
		    sudo sh -c "echo 'blacklist rtl2830' >> /etc/modprobe.d/blacklist-rtl.conf"
		    sudo sh -c "echo 'blacklist dvb_usb_rtl28xxu' >> /etc/modprobe.d/blacklist-rtl.conf"
		fi

		cd ~
		rm -rf rtl-sdr
	fi

    #   Install GR blocks
    #   ===============================================================
    if [ ! -e /usr/local/bin/osmocom_fft ]; then
        cd ~
        git clone --depth 1 --recursive git://git.osmocom.org/gr-osmosdr
        cd gr-osmosdr/
        mkdir build
        cmake ../
        make
        sudo make install
        sudo ldconfig
        cd ~
        rm -rf gr-osmosdr
    fi

    # if [ ! -e /usr/local/share/gnuradio/grc/blocks/baz_any.xml ]; then
    #     cd ~
    #     git clone --depth 1 --recursive git://github.com/balint256/gr-baz.git
    #     cd gr-baz
    #     mkdir build
    #     cmake ../
    #     make
    #     sudo make install
    #     sudo ldconfig
    #     cd ~
    #     rm -rf gr-baz
    # fi

    # inspectrum
    if [ ! -e /usr/local/bin/inspectrum ]; then 
        cd ~
	    git clone --depth 1 --recursive git@github.com:miek/inspectrum.git
	    cd inspectrum
	    mkdir build
	    cd build
	    cmake ..
	    make
	    sudo make install
	    cd ~
	    rm -rf inspectrum
    fi

    # SoapySDR
    if [ ! -e /usr/local/bin/SoapySDRUtil ]; then
        sudo apt-get install cmake g++ libpython-dev python-numpy swig

        cd ~
        git clone --recursive --depth 1 https://github.com/pothosware/SoapySDR.git
        cd SoapySDR
        mkdir build
        cd build
        cmake ..
        make -j4
        sudo make install
        sudo ldconfig #needed on debian systems
        SoapySDRUtil --info
        cd ~
        rm -rf SoapySDR
    fi

    # LimeSDR 
    if [ ! -e /usr/local/bin/LimeSuiteGUI ]; then
        #install core library and build dependencies
        sudo apt-get install git g++ cmake libsqlite3-dev

        #install hardware support dependencies
        sudo apt-get install libsoapysdr-dev libi2c-dev libusb-1.0-0-dev

        #install graphics dependencies
        sudo apt-get install libwxgtk3.0-dev freeglut3-dev

        cd ~
        git clone --recursive --depth 1 https://github.com/myriadrf/LimeSuite.git
        cd LimeSuite
        git checkout stable
        mkdir builddir && cd builddir
        cmake ../
        make -j4
        sudo make install
        sudo ldconfig
        cd ~
        rm -rf LimeSuite
    fi

    # PothosCore
    if [ ! -e /usr/local/bin/PothosFlow ]; then
        sudo apt-get install libnuma-dev cmake g++ libpython-dev python-numpy qtbase5-dev libqt5svg5-dev libqt5opengl5-dev libqwt-qt5-dev portaudio19-dev libjack-jackd2-dev graphviz

        cd ~
        git clone --recursive --depth 1 https://github.com/pothosware/PothosCore.git
    
        cd PothosCore
        #update to latest master branch
        git pull origin master

        #update submodules to latest tracking branch
        git submodule update --init --recursive --remote

        mkdir build
        cd build
        cmake ..
        make -j4
        sudo make install
        sudo ldconfig #needed on debian systems
        PothosUtil --self-tests
        # PothosFlow #launches GUI designer
        cd ~
        rm -rf PothosCore
    fi

    sudo pip2 install $pip2
    sudo pip3 install $pip3

elif [ $os == "Darwin" ]; then

    echo "Installing DRAW brewery dependences"
    
    # ON MacOX 
    brew update
    brew upgrade
    brew cleanup

    # https://github.com/daveio/homebrew-sdrtools
    brew install tcl-tk 
    # brew install python --with-tcl-tk

    pip2 install $pip2
    pip3 install $pip3

    brew install --build-from-source wxpython
    # brew install --build-from-source --python wxmac
    # brew install --build-from-source --with-icu4c boost

    brew tap pothosware/homebrew-pothos
    brew tap dholm/homebrew-sdr #other sdr apps
    brew update

    # brew install gnuradio -with-pygtk --with-wxpython 
    brew install gnuradio

    for one_thing in ${apps_common}; do
        brew install --build-from-source --HEAD $one_thing
    done

    for one_thing in ${apps_osx}; do
        brew install --build-from-source --HEAD $one_thing
    done
fi

#   Compile Dump1090
#   ===============================================================
# if [ ! -d ~/dump1090 ]; then
# 	cd ~
#     git clone --depth 1 --recursive https://github.com/itemir/dump1090_sdrplus
#     cd dump1090_sdrplus
#     # git checkout HackRF_One
#     make
#     sudo mv dump1090 /usr/local/bin
#     cd ~
#     rm -rf dump1090_sdrplus
# fi

if [ ! -d ~/rtl_433 ]; then
    cd ~
    git clone --depth 1 --recursive https://github.com/merbanan/rtl_433.git
    cd rtl_433
    mkdir build
    cd build
    cmake ../
    make
    sudo make install
fi

# #   RTLAMR
# #   ===============================================================
#if [ ! -e ~/gocode/bin/rtlamr ]; then
#    if [ ! -d ~/gocode ]; then
#        cd ~ 
#        mkdir gocode
#        export GOPATH=~/gocode
#        export PATH=$GOPATH/bin:$PATH
#    fi
#    go get github.com/bemasher/rtltcp
#    go get github.com/bemasher/rtlamr
#fi

#   LINK gnuradio
#   ===============================================================
cd ~
ln -s .dotfiles/gnuradio .gnuradio

