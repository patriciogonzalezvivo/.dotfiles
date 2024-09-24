#!/bin/bash

os=$(uname)
arq=$(uname -m)

apps_common="tmux mc htop vim zsh wget curl cmake pkg-config kitty mpv stow"
apps_osx="git sshfs glslang "
apps_linux_debian_common="git-core "
apps_linux_rpi="avahi-daemon "
apps_linux_ubuntu="exfat-fuse exfat-utils ranger mediainfo"
apps_linux_arch="git code glslang base-devel yajl "
config_files=(.gitconfig .tmux.conf .zshrc .vimrc .Xresources .fzf.zsh )
config_folders=(.vim .zsh .tmux)
config_subfolder=(kitty nvim)

#   Install Applications
#   ===============================================================
if [ $os == "Linux" ]; then

    # DEBIAN LINUX distributions
    if [ -e /usr/bin/apt ]; then

        # updata and install basics
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install $apps_common $apps_linux_debian_common

        # on RaspberryPi
        if [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
            sudo apt-get install $apps_linux_rpi

        # regular Ubuntu distro
        else
            sudo apt-get install $apps_linux_ubuntu
        fi
    
    # ARCH LINUX distribution
    elif [ -e /usr/bin/pacman ]; then

        sudo pacman -Sy
        sudo pacman -S $apps_common $apps_linux_arch    
    fi

elif [ $os == "Darwin" ]; then
    
    # ON MacOX 
    if test ! -e "/usr/local/bin/brew"  &&  test ! -e "/opt/homebrew/bin/brew" ; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    brew update
    brew upgrade
    brew install $apps_common $apps_osx
fi

#   Install Config files
#   ===============================================================

# If is a remote install install this repository
if [ ! -d ~/.dotfiles ]; then
    git clone --depth 1 --recursive https://github.com/patriciogonzalezvivo/.dotfiles.git ~/.dotfiles
fi

if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

#   update files and submodules
cd ~/.dotfiles
git pull
git submodule update --init .vim/bundle/Vundle.vim
cd  .vim/bundle/Vundle.vim 
git checkout master
git pull

#   go to root path
cd ~

if [ ! -d .oh-my-zsh ]; then
    chsh -s $(which zsh)
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    git clone --depth 1 https://github.com/valentinocossar/vscode.git .oh-my-zsh/custom/plugins/vscode
    git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git .oh-my-zsh/custom/plugins/fzf-zsh-plugin
fi

#   clean files
for i in ${config_files[@]}; do
    rm -f ${i}
done

#   clean folders
for i in ${config_folders[@]}; do
    rm -rf ${i}
done

if [ ! -d .mutt ]; then
    mkdir -p .mutt/cache/headers/../bodies
    touch .mutt/certificates
    touch .mutt/credentials
    touch .mutt/folders
    touch .mutt/aliases
fi

for i in ${config_files[@]}; do
    echo ${i}
    ln -s ~/.dotfiles/${i} ${i}
done

for i in ${config_folders[@]}; do
    echo ${i}
    ln -s ~/.dotfiles/${i} ${i}
done

for i in ${config_subfolder[@]}; do
    echo ${i}
    ln -s ~/.dotfiles/${i} ~/.config/${i}
done

vim +PluginInstall +qall

