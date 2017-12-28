#!/bin/bash

sudo apt-get install xfce4 xfce4-goodies wpagui
sudo apt-get --purge remove lxde
sudo apt-get remove lxappearance lxde-* lxinput lxmenu-data lxpanel lxpolkit lxrandr lxsession* lxsession lxshortcut lxtask lxterminal
sudo apt-get clean
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get install wpagui

cd ~
if [ ! -d ~/.icons ]; then
	mkdir .icons
fi

if [ ! -d ~/.icons/numix-icon-theme ]; then
	cd ~/.icons
	git clone https://github.com/numixproject/numix-icon-theme
else
	cd ~/.icons/numix-icon-theme
	git pull
fi

cd ~/.icons
ln -s numix-icon-theme/Numix Numix
ln -s numix-icon-theme/Numix-Light Numix-Light

if [ ! -d ~/.icons/numix-icon-theme-circle  ]; then
	cd ~/.icons
	git clone https://github.com/numixproject/numix-icon-theme-circle
else
	cd ~/.icons/numix-icon-theme-circle 
	git pull
fi

cd ~/.icons
ln -s numix-icon-theme-circle/Numix-Circle Numix-Circle
ln -s numix-icon-theme-circle/Numix-Circle-Light Numix-Circle-Light

if [ ! -d ~/.themes ]; then
	mkdir ~/.themes
fi

if [ ! -d ~/.themes/Numix ]; then
	cd ~/.themes
	git clone https://github.com/shimmerproject/Numix
else
	cd ~/.themes/Numix
	git pull
fi

xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"
xfconf-query -c xfwm4 -p /general/theme -s "Numix"

if [ -d ~/.config/xfce4 ]; then
	rm -rf ~/.config/xfce4
fi

cd ~/.config/
ln -s ~/.dotfiles/rpi/xfce4 xfce4
cp ~/.dotfiles/data/Pictures/* ~/Pictures/

cd ~

