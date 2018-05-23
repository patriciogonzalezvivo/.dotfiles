#!/bin/bash

os=$(uname)
arq=$(uname -m)
addons=(patriciogonzalezvivo/ofxFluid patriciogonzalezvivo/ofxFX patriciogonzalezvivo/ofxSmartShader)
projects=(patriciogonzalezvivo/SkyMap patriciogonzalezvivo/Solar patriciogonzalezvivo/Luna patriciogonzalezvivo/Estrellas)

if [ -d ~/Desktop ]; then
    cd ~/Desktop
fi

# Clone the repsitory
git clone --depth 1 --recursive https://github.com/openframeworks/openFrameworks.git
cd openframeworks

# Download Libraries, dependences and Codecs
if [ $os == "Linux" ]; then
    cd scripts/linux 
    ./download_libs.sh
    if [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
        cd debian
        sudo ./install_dependencies.sh
        sudo ./install_codecs.sh
        cd ..
    else
        cd ubuntu
        sudo ./install_dependencies.sh
        sudo ./install_codecs.sh
        cd ..
    fi
    ./compileOF.sh
    ./compilePG.sh
    cd ..
elif [ $os == "Darwin" ]; then
    cd scripts/osx
    ./download_libs.sh
fi

# Build ProjectGenerator
cd apps/projectGenerator
cd scripts
if [ $os == "Linux" ]; then
    cd linux
elif [ $os == "Darwin" ]; then
    cd osx
fi
./buildPG.sh
cd ..

# Build Commandline Project Generator
cd commandLine/
make
cd bin
./projectGenerator -r -o"../../../../" ../../../../examples

# Install addons
cd ../../../addons
for i in ${addons[@]}; do
    git clone --depth 1 --recursive git@github.com:${i}.git
done

# Install projects
cd ../apps
if [ ! -d myApps ]; then
    mkdir myApps
fi
cd myApps
for i in ${projects[@]}; do
    git clone --depth 1 --recursive git@github.com:${i}.git
done
