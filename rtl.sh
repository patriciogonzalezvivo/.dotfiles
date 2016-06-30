#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common="cmake minimodem "
apps_osx="libusb sox "
apps_linux_common="build-essential pkg-config cmake libusb-1.0-0-dev libconfig-dev libjpeg-dev libconfig9 libboost-dev sqlite pyqt4-dev-tools liblog4cpp5-dev swig gnuradio gnuradio-dev gr-osmosdr qsstv ax25-apps ax25mail-utils ax25-node ax25-tools ax25-xtools soundmodem libfftw3-dev qt5-default"
apps_linux_rpi="direwolf python-numpy"
apps_linux_ubuntu=""

if [ $os == "Linux" ]; then

    # on Debian Linux distributions
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install $apps_common
    sudo apt-get install $apps_linux_common

    # on RaspberryPi
    if [ $arq == "armv7l" ]; then
        sudo apt-get install $apps_linux_rpi
	
	    cd ~
        git clone git@github.com:F5OEO/rpitx.git
        cd rpitx
        ./install.sh
        cd ..
        rm -rf rpitx

    else
        sudo apt-get install $apps_linux_ubuntu
    fi

    #   Install OSMCOM drivers
	#   ===============================================================
	if [ ! -e /etc/udev/rules.d/rtl-sdr.rules ]; then
		cd ~
		git clone git://git.osmocom.org/rtl-sdr.git
		cd rtl-sdr/
		mkdir build
		cd build
		cmake ../ -DCMAKE_INSTALL_PREFIX=/usr -DINSTALL_UDEV_RULES=ON
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

    if [ ! -e /usr/local/bin/inspectrum ]; then 
        cd ~
	    git clone git@github.com:miek/inspectrum.git
	    cd inspectrum
	    mkdir build
	    cd build
	    cmake ..
	    make
	    sudo make install
	    cd ~
	    rm -rf inspectrum
    fi

elif [ $os == "Darwin" ]; then
    
    # ON MacOX 
    brew update
    brew upgrade
    brew install $apps_common
    brew install $apps_osx

    # https://github.com/chleggett/homebrew-gqrx?files=1
    #brew install librtlsdr --HEAD
    #brew tap chleggett/gqrx
	#brew tap chleggett/gr-osmosdr
	#brew install gqrx

	# http://uberhip.com/rtlsdr/osx/gqrx/2015/10/17/OS_X_El_Capitan_GQRX_HackRF/
	brew tap godber/godber
	brew update

	# install some dependencies just in case
	brew install gnuradio
	brew install rtl-sdr
	brew install hackrf

	# install osmosdr and gqrx from my tap
	brew install gnuradio-osmosdr
	brew install gqrx
	brew linkapps gqrx
fi

#   Install GR Air modes
#   ===============================================================
if [ ! -d ~/gr-air-modes ]; then
	cd ~
	git clone https://github.com/bistromath/gr-air-modes.git
	cd gr-air-modes
	mkdir build
	cmake ../
	make
	sudo make install
	sudo ldconfig
	cd ~
fi

#   Compile Dump1090
#   ===============================================================
if [ ! -d ~/dump1090 ]; then
	cd ~
    git clone git://github.com/MalcolmRobb/dump1090.git
    cd dump1090
    make
    cd ~
fi

