#!/bin/bash

os=$(uname)
arq=$(uname -m)
addons=(jeffcrouse/ofxJSON patriciogonzalezvivo/ofxSDFFont patriciogonzalezvivo/ofxFX patriciogonzalezvivo/ofxShader patriciogonzalezvivo/ofxLabels)
projects=(patriciogonzalezvivo/Serial patriciogonzalezvivo/Orbits patriciogonzalezvivo/SkyMaps patriciogonzalezvivo/Solar patriciogonzalezvivo/Luna patriciogonzalezvivo/Estrellas patriciogonzalezvivo/Orbits patriciogonzalezvivo/Sol)

if [ -d ~/Desktop ]; then
    cd ~/Desktop
fi

# Clone the repsitory
git clone --depth 1 --recursive git@github.com:openframeworks/openFrameworks.git
cd openFrameworks

# Download Libraries, dependences and Codecs
if [ $os == "Linux" ]; then
    pushd scripts/linux 
    ./download_libs.sh
    if [ $arq == "armv6l" ] || [ $arq == "armv7l" ]; then
        pushd debian
        sudo ./install_dependencies.sh
        sudo ./install_codecs.sh
        popd
    else
        pushd ubuntu
        sudo ./install_dependencies.sh
        sudo ./install_codecs.sh
        popd
    fi
    ./compileOF.sh
    ./compilePG.sh
    popd
elif [ $os == "Darwin" ]; then
    pushd scripts/osx
    ./download_libs.sh
    popd
fi

# Build ProjectGenerator
pushd apps/projectGenerator
    pushd scripts
        if [ $os == "Linux" ]; then
          pushd linux
        elif [ $os == "Darwin" ]; then
          pushd osx
        fi
        ./buildPG.sh
        popd
    popd

    # Build Commandline Project Generator
    pushd commandLine/
        make
        pushd bin
        ./projectGenerator -r -o"../../../../" ../../../../examples
        popd
    popd
popd

# Install addons
pushd addons
for i in ${addons[@]}; do
    git clone --depth 1 --recursive git@github.com:${i}.git
done
popd

# Install projects
pushd apps
    if [ ! -d myApps ]; then
        mkdir myApps
    fi
    pushd myApps
    for i in ${projects[@]}; do
        git clone --depth 1 --recursive git@github.com:${i}.git
    done
    popd
popd
