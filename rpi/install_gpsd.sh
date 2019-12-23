#!/bin/bash

#script to install GPS Dongle for Raspberry Pi 
#km4ack 20190911
#Last Edit km4ack 20191014

#check if running as root
IAM=$(whoami)
if [ $IAM = "root" ]
then
echo 
else
echo "Please run this script as root"
exit 0
fi

#install needed packages
echo "installing a few needed packages"
apt-get install -y gpsd gpsd-clients python-gps chrony

#backup gpsd file
mv /etc/default/gpsd /etc/default/gpsd.org

#download gpsd file
wget https://raw.githubusercontent.com/km4ack/pi-scripts/master/gpsd -P /etc/default/

echo "refclock SHM 0 offset 0.5 delay 0.2 refid NMEA" >> /etc/chrony/chrony.conf

echo "";echo "";echo ""
echo "#############################################################################################"
echo "#instructions at https://raw.githubusercontent.com/km4ack/pi-scripts/master/gps-instruction #"
echo "#############################################################################################"
echo "Reboot is needed to complete"
#echo "Would you like to reboot now? y/n"
#read ANSW

#if [ $ANSW = "y" ]
#then
#reboot
#else
#echo "GPS won't work until reboot"
#exit 0
#fi
