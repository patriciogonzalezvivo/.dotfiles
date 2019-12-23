# Raspberry Pi Zero connected to Celestrone Telescope

## Initial set up

1. Install git

```bash
sudo apt-get install git-core
```

2. Clone this repo at the home folder

```bash
cd ~  
git clone git://github.com/patriciogonzalezvivo/.dotfiles.git
cd .dotfiles
```

3. Run Install Core Apps

```bash
./install_core.sh
./install_telescope.sh
```

Optional

``` bash
./install_tools.sh
./install_net.sh
./install_sdr.sh
./install_python.sh
```


## Derive power from the Celestron NextStar controller

Go and follow [this document to get all the needed hardware and do the right steps to derive power from the NextStar controller](https://hackaday.io/project/21088/instructions).

Note: I'm not connecting to the controller through GPIO, I prefere to use the regular mini-USB port and be hable to unplug the raspberry pi if it's needed.

When it comes to the software you need to install on your Raspberry pi do:

```bash
sudo apt-get install cdbs libcfitsio3-dev libnova-dev libusb-1.0-0-dev libjpeg-dev \
                libusb-dev libtiff5-dev libftdi-dev fxload libkrb5-dev libcurl4-gnutls-dev \
                libraw-dev libgphoto2-dev libgsl0-dev dkms libboost-regex-dev libgps-dev \
                libdc1394-22-dev

sudo mkdir /opt/libindi
pushd /opt/libindi
  sudo curl -o libindi_rpi.tgz -L http://indilib.org/download/raspberry-pi/send/6-raspberry-pi/9-indi-library-for-raspberry-pi.html
  sudo tar -xzf libindi_rpi.tgz --strip 1

  sudo dpkg -i *.deb
  sudo apt-get -f install
popd
```

Install the indi server web manager

```bash
sudo apt-get install python-requests python-psutil python-bottle

sudo apt-get install git
sudo git clone http://github.com/knro/indiwebmanager /opt/indiwebmanager

sudo cp /opt/indiwebmanager/indiwebmanager.service /lib/systemd/system/
sudo sed -i 's|/home/pi|/opt/indiwebmanager|g' /lib/systemd/system/indiwebmanager.service
sudo sed -i 's/User=pi/User=root/g' /lib/systemd/system/indiwebmanager.service
sudo chmod 644 /lib/systemd/system/indiwebmanager.service
sudo ln -s /lib/systemd/system/indiwebmanager.service /etc/systemd/system/multi-user.target.wants/indiwebmanager.service
```

Reboot your RPi
Wait for it to come back up
Use a browser to open the server manager at port 8624 (with my config, it's as simple as http://nexstar-6se:8624/)
Create a new profile that includes the "Celestron NexStar" driver
Save the profile
Start the server


## Install Hostspot

```bash
cd ~/.dotfiles/rpi
sudo ./install_hotspot.sh
```

Follow the onscreen instructions when prompted during the install.

```bash
crontab -e
```

If this is the first time you are using cron, you will need to pick your editor. I use nano and this tutorial will reference the nano editor anytime we need to make a mod to a text or config file. Scroll to the bottom of the crontab by using the down arrow on your keyboard. Then paste the following lines. The first is just a comment as indicated by the "#" at the beginning of the line. The second line is the command.

```
#run auto hotspot script every 5 minutes
*/5 * * * * sudo /usr/bin/autohotspotN > /dev/null 2>&1
```

To exit the nano editor, press 'ctrl+x' on the keyboard, then 'y', then 'enter'

One last thing to do. I like to modify the hotspot name that appears on your wireless device. Follow these instructions to customize yours. Run

```bash
sudo nano /etc/hostapd/hostapd.conf
```

Look for the line SSID=RPiHotspot and change the hotspot name to be what you want. Be sure to leave the SSID= at the beginning of the line. Everything beyond the '=' is the hotspot name. Don't use spaces in the name. The line should look like this SSID=NEW-HOTSPOT-NAME

Save and close nano as before.

```bash
reboot
```
