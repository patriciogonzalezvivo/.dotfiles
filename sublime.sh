#!/bin/bash
os=$(uname)
arq=$(uname -m)
        
if [ $os == "Linux" ]; then

	# on RaspberryPi
    if [ $arq == "armv7l" ]; then
    	echo "No sublime for RaspberryPi yet"
    else
		if [ ! -e /usr/bin/subl ]; then
		    sudo add-apt-repository ppa:webupd8team/sublime-text-3
		    sudo apt-get update
		    sudo apt-get install sublime-text-installer
		fi
	fi
elif [ $os == "Darwin" ]; then
	echo "Manually install it"
fi