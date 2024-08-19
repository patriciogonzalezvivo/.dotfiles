#!/bin/bash

# .././install_themes.sh
sudo apt-get install awesome wpagui compton rofi i3lock-fancy kbdd libxcb-cursor-dev

xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"
xfconf-query -c xfwm4 -p /general/theme -s "Numix"

if [ -d ~/.config/awesome ]; then
	rm -rf ~/.config/awesome
fi

cd ~/.config/
ln -s ~/.dotfiles/rpi/awesome awesome
ln -s ~/.dotfiles/rpi/compton.conf compton.conf

cd ~

# TODO:
# - install latest version of rofi https://github.com/davatorium/rofi/
# 		git clone --recursive --depth 1 https://github.com/DaveDavenport/rofi
#		cd rofi
#		autoreconf -i
#       mkdir build && cd build
#		../configure --prefix=/usr/
#		make
#		sudo make install
