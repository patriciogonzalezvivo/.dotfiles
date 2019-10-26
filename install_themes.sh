#!/bin/bash

os=$(uname)
        
if [ $os == "Linux" ]; then
    cd ~/.dotfiles
    git pull
    git submodule init
    git submodule update
    git submodule foreach git checkout master
    git submodule foreach git pull

    cd ~
    ln -s .dotfiles/icons .icons
    ln -s .dotfiles/themes .themes
fi
