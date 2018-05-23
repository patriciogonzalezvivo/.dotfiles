#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common=""
apps_osx=""
apps_linux_common=""
apps_linux_rpi="cdbs libcfitsio-dev libnova-dev libusb-1.0-0-dev libjpeg-dev libusb-dev libtiff5-dev libftdi-dev fxload libkrb5-dev libcurl4-gnutls-dev libraw-dev libgphoto2-dev libgsl0-dev dkms libboost-regex-dev libgps-dev libdc1394-22-dev python-requests python-psutil python-bottle"
apps_linux_ubuntu=""

cd ~ 
if [ ! -d Spatial ]; then
  git clone --depth 1 --recursive git@github.com:patriciogonzalezvivo/Spatial.git
  cd Spatial
  make deps
  make append_config
  make append_modules
  make
fi

if [ $os == "Linux" ]; then

    # on Debian Linux distributions
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install $apps_common
    sudo apt-get install $apps_linux_common

    # on RaspberryPi
    if [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
        sudo apt-get install $apps_linux_rpi

        mkdir /opt/libindi
        pushd /opt/libindi
          curl -o libindi_rpi.tgz -L http://indilib.org/download/raspberry-pi/send/6-raspberry-pi/9-indi-library-for-raspberry-pi.html
          tar -xzf libindi_rpi.tgz --strip 1
 
          dpkg -i *.deb
          sudo apt-get -f install 
        popd

        git clone http://github.com/knro/indiwebmanager /opt/indiwebmanager
        cp /opt/indiwebmanager/indiwebmanager.service /lib/systemd/system/

        sed -i 's|/home/patricio|/opt/indiwebmanager|g' /lib/systemd/system/indiwebmanager.service
        sed -i 's/User=patricio/User=root/g' /lib/systemd/system/indiwebmanager.service
        chmod 644 /lib/systemd/system/indiwebmanager.service
        ln -s /lib/systemd/system/indiwebmanager.service /etc/systemd/system/multi-user.target.wants/indiwebmanager.service

        echo "INDI web admin running on localhost:8624"

    else
        sudo apt-get install $apps_linux_ubuntu
    fi

elif [ $os == "Darwin" ]; then
    
    # ON MacOX 
    brew update
    brew upgrade
    brew cleanup
    brew install $apps_common
    brew install $apps_osx
fi


