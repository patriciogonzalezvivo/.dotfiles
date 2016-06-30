#!/bin/bash

sudo apt-get install libao-dev avahi-utils libavahi-compat-libdnssd-dev libva-dev youtube-dl
wget -O rplay-1.0.1-armhf.deb http://www.vmlite.com/rplay/rplay-1.0.1-armhf.deb
sudo dpkg -i rplay-1.0.1-armhf.deb
rm -f rplay-1.0.1-armhf.deb

echo "Reboot and go to http://localhost:7100/admin"
echo "Scroll down the license key is S1377T8072I7798N4133R"
