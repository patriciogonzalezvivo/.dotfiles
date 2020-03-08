# Razer Blade Stealth 2019

This documents focus for now on Ubuntu 19.10 but I'm planning to move to Majaro next year and [this](https://medium.com/@dtateii/project-razer-blade-stealth-ssd-upgrade-arch-linux-windows-f827af3a0347) will became more handy.


## Initial set up

1. Install git

```bash
sudo apt-get install git-core
```

2. Clone this repo at the home folder

```bash
cd ~  
git clone git://github.com/patriciogonzalezvivo/.dotfiles.git
cd .dotfiles
```

3. Run Install Core Apps

```bash
./install_core.sh 
./install_themes.sh
./install_tools.sh
./install_net.sh
./install_python.sh
cd razer
./install.sh
```


## Intel/Nvidia Hybrid mode

This little tool will let you choose between Intel only/ Nvidia only or on-demand Nvidia (or offloading) with [mate-optimus](https://github.com/ubuntu-mate/mate-optimus)

First make sure you are running your `NVIDA 435` drivers.

```bash
sudo apt install mate-optimus
```

Wrappers, called offload-glx & offload-vulkan can be used to easily offload games and applications to the PRIME renderer. For example:

```bash
offload-glx glmark2
offload-vulkan vkcube
```


## LED Keyboard

```bash
sudo add-apt-repository ppa:openrazer/stable
sudo apt update
```

At the moment of writing this the Razer Blade Stealth 2019 keyboard is not part of the suported devices. To fix:

```bash
git clone https://github.com/echapman2022/openrazer.git -b feature_stealthlate2019
cd openrazer
make
./scripts/build_debs.sh
sudo dpkg -i ./dist/*deb
```

Now we can install the rest of the packeges

```bash
sudo apt install openrazer-meta
```

And then the [Polychromatic](https://github.com/polychromatic/polychromatic) app instalation.

```bash
sudo add-apt-repository ppa:polychromatic/stable
sudo apt update
sudo apt install polychromatic
```


## Windows Hello face recognition with [Howdy](https://github.com/boltgolt/howdy)

PIP changed their entry point so /usr/bin/pip3 is broke.

```bash
sudo vim /usr/bin/pip3
```

Change `from pip._internal import main` to `from pip._internal.main import main`


```bash
sudo add-apt-repository ppa:boltgolt/howdy
sudo apt update
sudo apt install howdy
```

## Installing Blender 2.82 with CUDA support and native python

```bash
sudo add-apt-repository ppa:thomas-schiex/blender
sudo apt-get update
sudo apt-get install blender
```
