#!/bin/bash

.././install_themes.sh

sudo apt-get install xfce4 xfce4-goodies wpagui
sudo apt-get --purge remove lxde
sudo apt-get remove lxappearance lxde-* lxinput lxmenu-data lxpanel lxpolkit lxrandr lxsession* lxsession lxshortcut lxtask lxterminal
sudo apt-get clean
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get install wpagui

xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"
xfconf-query -c xfwm4 -p /general/theme -s "Numix"

if [ -d ~/.config/xfce4 ]; then
	rm -rf ~/.config/xfce4
fi

cd ~/.config/
ln -s ~/.dotfiles/rpi/xfce4 xfce4

cd ~

