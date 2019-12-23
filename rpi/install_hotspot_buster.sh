#!/bin/bash

#install autohotspot from raspberrypiconnect.com
#http://www.raspberryconnect.com/network/item/330-raspberry-pi-auto-wifi-hotspot-switch-internet
#This version will provide internet when using the hotspot IF an ethernet cable is plugged in"
#This will be useful with AREDN mesh networking
#This script is for Buster ONLY
#Stretch users should use https://github.com/km4ack/pi-scripts/blob/master/autohotspotN-setup
#km4ack 20190923

#update packages
apt-get update

#install hostapd, dnsmasq
apt-get install -y hostapd
apt-get install -y dnsmasq

#remove hostapd mask
systemctl unmask hostapd

#stop both services
systemctl disable hostapd
systemctl disable dnsmasq

mkdir -p $HOME/temp

wifipass () {
echo;echo;echo
echo "This password will be used to connect to the pi"
echo "when the pi is in hotspot mode"
#credit next line to Ray, N3HYM
echo "Password should be between 8-63 characters"
read -p "Enter password to use with new hotspot " wifipasswd
COUNT=${#wifipasswd}
if [ $COUNT -lt 8 ]
then
echo "Password must be at least 8 characters long"
sleep 2
wifipass
fi
echo;echo
echo "You entered $wifipasswd"
read -p "Is this correct? y/n " wifians
if [ $wifians == "y" ]
then
echo
else
wifipass
fi
}

wifipass

cd $HOME/temp

wget http://www.raspberryconnect.com/images/Autohotspot/autohotspot-95-4/hostapd.txt

#set new hotspot passwd
sed -i "s/wpa_passphrase=1234567890/wpa_passphrase=$wifipasswd/" $HOME/temp/hostapd.txt
#set country to US
sed -i 's/country_code=GB/country_code=US/' $HOME/temp/hostapd.txt

#move hostapd to correct location
mv $HOME/temp/hostapd.txt /etc/hostapd/hostapd.conf

sed -i s'/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/' /etc/default/hostapd
sed -i s'/DAEMON_OPTS=""/#DAEMON_OPTS=""/' /etc/default/hostapd

#add needed info to dnsmasq.conf
echo "#AutoHotspot config" >> /etc/dnsmasq.conf
echo "interface=wlan0" >> /etc/dnsmasq.conf
echo "bind-dynamic" >> /etc/dnsmasq.conf
echo "server=8.8.8.8" >> /etc/dnsmasq.conf
echo "domain-needed" >> /etc/dnsmasq.conf
echo "bogus-priv" >> /etc/dnsmasq.conf
echo "dhcp-range=10.10.10.150,10.10.10.200,255.255.255.0,12h" >> /etc/dnsmasq.conf
echo "#Set up redirect for email.com" >> /etc/dnsmasq.conf
echo "dhcp-option=3,10.10.10.10" >> /etc/dnsmasq.conf
echo "address=/email.com/10.10.10.10" >> /etc/dnsmasq.conf

mv /etc/network/interfaces /etc/network/interfaces.org

echo "source-directory /etc/network/interfaces.d" >> /etc/network/interfaces


echo "nohook wpa_supplicant" >> /etc/dhcpcd.conf

#setup ip forward
sed 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf

cd $HOME/temp

wget http://www.raspberryconnect.com/images/autohotspotN/autohotspotn-95-4/autohotspot-service.txt

#create autohotspot service file
mv autohotspot-service.txt /etc/systemd/system/autohotspot.service

#start autohotspot service
systemctl enable autohotspot.service

#check if iw installed. install if not

iwcheck=$(dpkg --get-selections | grep -w "iw")
if [ -z "iw" ]
then
apt-get install iw
fi

#install autohotspot script
cd $HOME/temp
wget http://www.raspberryconnect.com/images/autohotspotN/autohotspotn-95-4/autohotspotN.txt
#mod ip address for our custom setup
sed -i 's/192.168.50.5/10.10.10.10/' autohotspotN.txt
mv autohotspotN.txt /usr/bin/autohotspotN
chmod +x /usr/bin/autohotspotN

#shackwifi function
shackwifi1 () {
#get ham's wifi credentials
echo "What wifi SSID would you like to connect to?"
echo "This is the one already in your shack"
read shackwifi
echo "What is the password for this wifi?"
read shackpass

echo;echo;
echo "Your shack's current wifi is"
echo "wifi $shackwifi"
echo "passwd $shackpass"
echo "Is this correct? y/n"
read shackans
if [ $shackans == "y" ]
then
echo
else
shackwifi1
fi
}

#run shackwifi function
shackwifi1

#add shack wifi to wpa_supplicant.conf
echo "network={" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "ssid=\"$shackwifi\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "psk=\"$shackpass\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "key_mgmt=WPA-PSK" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "}" >> /etc/wpa_supplicant/wpa_supplicant.conf

echo;echo;echo
echo "A reboot is required to complete the setup"
echo "Wifi/AutoHotSpot will not work until reboot"
echo "Ignore this IF you are using the EES quickinstall"
