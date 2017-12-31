#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common="cmake python3 minimodem swig gr-osmosdr "
apps_osx="libusb sox rtlsdr librtlsdr hackrf airspy inspectrum gr-baz gr-fosphor libmirisdr"
apps_linux_common="build-essential pkg-config libusb-1.0-0 libusb-1.0-0-dev libhackrf0 libhackrf-dev libsoxr0 libsoxr-dev libairspy0 libairspy-dev libmirisdr0 libmidirsdr-dev ibconfig-dev libjpeg-dev libconfig9 libboost-dev sqlite pyqt4-dev-tools liblog4cpp5-dev gnuradio-dev qsstv ax25-apps ax25mail-utils ax25-node ax25-tools ax25-xtools soundmodem libfftw3-dev qt5-default"
apps_linux_rpi="direwolf "
apps_linux_ubuntu=""

pip2="Cheetah lxml matplotlib numpy scipy docutils sphinx"
pip3="urh"

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

    pip2 install $pip2
    pip3 install $pip3

elif [ $os == "Darwin" ]; then
    
    # ON MacOX 
    brew update
    brew upgrade
    brew cleanup

    # https://github.com/daveio/homebrew-sdrtools
    brew install tcl-tk 
    brew install python --with-tcl-tk

    pip2 install $pip2
    pip3 install $pip3

    brew install --build-from-source wxpython
    brew install --build-from-source --python wxmac
    brew install --build-from-source --with-icu4c boost

    brew tap pothosware/homebrew-pothos
    brew tap dholm/homebrew-sdr #other sdr apps
    brew update

    brew install gnuradio -with-pygtk --with-wxpython 

    for one_thing in ${(z)apps_common}; do
        brew install --build-from-source --HEAD $one_thing
    done

    for one_thing in ${(z)apps_osx}; do
        brew install --build-from-source --HEAD $one_thing
    done
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
    git clone https://github.com/itemir/dump1090_sdrplus
    cd dump1090_sdrplus
    git checkout HackRF_One
    make
    cd ~
fi

cd ~
ln -s .dotfiles/gnuradio .gnuradio

