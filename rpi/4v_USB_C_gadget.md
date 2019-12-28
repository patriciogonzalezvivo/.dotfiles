# Turning a RaspberryPi 4v into USB-C Gadget


Tutorial from [here](https://www.hardill.me.uk/wordpress/2019/11/02/pi4-usb-c-gadget/)


 * Add `dtoverlay=dwc2` to the `/boot/config.txt`
 * Add `modules-load=dwc2` to the end of `/boot/cmdline.txt`
 * If you have not already enabled ssh then create a empty file called `ssh` in `/boot`
 * Add `libcomposite` to `/etc/modules`
 * Add `denyinterfaces usb0` to `/etc/dhcpcd.conf`
 * Install dnsmasq with `sudo apt-get install dnsmasq`
 * Create `/etc/dnsmasq.d/usb` with following content

```
interface=usb0
dhcp-range=10.55.0.2,10.55.0.6,255.255.255.248,1h
dhcp-option=3
leasefile-ro
```

 * Create `/etc/network/interfaces.d/usb0` with the following content

```
auto usb0
allow-hotplug usb0
iface usb0 inet static
  address 10.55.0.1
  netmask 255.255.255.248
```

 * Create `/root/usb.sh`

```
#!/bin/bash
cd /sys/kernel/config/usb_gadget/
mkdir -p pi4
cd pi4
echo 0x1d6b > idVendor # Linux Foundation
echo 0x0104 > idProduct # Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB # USB2
echo 0xEF > bDeviceClass
echo 0x02 > bDeviceSubClass
echo 0x01 > bDeviceProtocol
mkdir -p strings/0x409
echo "fedcba9876543211" > strings/0x409/serialnumber
echo "Ben Hardill" > strings/0x409/manufacturer
echo "PI4 USB Device" > strings/0x409/product
mkdir -p configs/c.1/strings/0x409
echo "Config 1: ECM network" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower
# Add functions here
# see gadget configurations below
# End functions
mkdir -p functions/ecm.usb0
HOST="00:dc:c8:f7:75:14" # "HostPC"
SELF="00:dd:dc:eb:6d:a1" # "BadUSB"
echo $HOST > functions/ecm.usb0/host_addr
echo $SELF > functions/ecm.usb0/dev_addr
ln -s functions/ecm.usb0 configs/c.1/
udevadm settle -t 5 || :
ls /sys/class/udc > UDC
ifup usb0
service dnsmasq restart
```


 * Make `/root/usb.sh` executable with `chmod +x /root/usb.sh`
 * Add `/root/usb.sh` to `/etc/rc.local` before `exit 0` (I really should add a systemd startup script here at some point)

With this setup the Pi4 will show up as a ethernet device with an IP address of 10.55.0.1 and will assign the device you plug it into an IP address via DHCP. This means you can just ssh to pi@10.55.0.1 to start using it.
