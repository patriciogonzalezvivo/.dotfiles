#!/bin/bash

sudo apt-get install --fix-missing lsb lsb-core
sudo update-rc.d -f cups remove
wget https://secure.logmein.com/labs/logmein-hamachi_2.1.0.139-1_armhf.deb
sudo dpkg -i logmein-hamachi_2.1.0.139-1_armhf.deb

hostname=$(hostname)
echo "Add email of the account"
read account
echo "Add network ID"
read network

sudo hamachi login
sudo hamachi attach $
sudo hamachi set-nick $hostname
sudo hamachi do-join $network

sudo apt-get install privoxy

echo "Open /etc/privoxy/config"
echo "and change: "
echo "	listen-address localhost:811"
echo "for:"
echo "	listen-address [IP address of your Pi assigned by Hamachi]:8118"

rm logmein-hamachi_2.1.0.139-1_armhf.deb
