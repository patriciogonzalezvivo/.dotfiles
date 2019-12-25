#!/bin/bash

#script to install GPS Dongle for Raspberry Pi 
#km4ack 20190911
#Last Edit km4ack 20191014

#!/bin/bash

os=$(uname)
arq=$(uname -m)

# apps_common="lsof tcpdump dstat iotop fail2ban nmap ngrep aircrack-ng "
# apps_osx="nc "
apps_linux_debian_common="gpsd gpsd-clients python-gps chrony"
apps_linux_arch="gpsd gpsd-clients python-gps chrony"   

if [ $os == "Linux" ]; then

    # DEBIAN LINUX distributions
    if [ -e /usr/bin/apt ]; then

        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install -y $apps_linux_debian_common 

        #install needed packages
        echo "installing a few needed packages"
        apt-get install -y 

        #backup gpsd file
        sudo mv /etc/default/gpsd /etc/default/gpsd.org

        #download gpsd file
        sudo mv gspd /etc/default/

        echo "refclock SHM 0 offset 0.5 delay 0.2 refid NMEA" >> /etc/chrony/chrony.conf

        echo "";echo "";echo ""
        echo "#############################################################################################"
        echo "#instructions at https://raw.githubusercontent.com/km4ack/pi-scripts/master/gps-instruction #"
        echo "#############################################################################################"
        echo "Reboot is needed to complete"
    fi
fi
