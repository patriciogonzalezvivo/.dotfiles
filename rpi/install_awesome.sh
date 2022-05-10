#!/bin/bash

.././install_themes.sh

sudo apt-get install awesome wpagui

xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"
xfconf-query -c xfwm4 -p /general/theme -s "Numix"

if [ -d ~/.config/awesome ]; then
	rm -rf ~/.config/awesome
fi

cd ~/.config/
ln -s ~/.dotfiles/rpi/awesome awesome

cd ~

