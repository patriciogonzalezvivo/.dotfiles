#!/bin/bash

sudo visudo
sudo usermod -a -G video $1
sudo usermod -a -G dialout $1
sudo usermod -a -G netdev $1
