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

    if [ -e /usr/bin/gnome-terminal ]; then
        gsettings set org.gnome.Terminal.Legacy.Settings headerbar "@mb false"
    fi

    # TODO: Add script for changing GDM login them
    #       follow https://github.com/nana-4/materia-theme/blob/master/src/gnome-shell/README.md

fi
