#!/bin/bash

sudo adduser $1 
sudo visudog
sudo usermod -a -G pi $1
sudo usermod -a -G adm $1
sudo usermod -a -G sudo $1
sudo usermod -a -G video $1
sudo usermod -a -G audio $1
sudo usermod -a -G plugdev $1
sudo usermod -a -G dialout $1
sudo usermod -a -G netdev $1
sudo usermod -a -G input $1
sudo usermod -a -G gpio $1
sudo usermod -a -G i2c $1
sudo usermod -a -G spi $1
