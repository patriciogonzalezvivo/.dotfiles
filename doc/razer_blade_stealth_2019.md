# Razer Blade Stealth 2019

This documents focus for now on Ubuntu 19.10 but I'm planning to move to Majaro next year and [this](https://medium.com/@dtateii/project-razer-blade-stealth-ssd-upgrade-arch-linux-windows-f827af3a0347) will became more handy.


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

Change `pip._internal import main` to `from pip._internal.main import main`


```bash
sudo add-apt-repository ppa:boltgolt/howdy
sudo apt update
sudo apt install howdy
```

## Compiling Blender to use the GTX Nvidia card

https://wiki.blender.org/wiki/Building_Blender

```bash
sudo apt update
sudo apt install build-essential git subversion cmake libx11-dev libxxf86vm-dev libxcursor-dev libxi-dev libxrandr-dev libxinerama-dev
mkdir ~/blender-git
cd ~/blender-git
git clone http://git.blender.org/blender.git
```

For Intel and AMD x86-64 Linux systems, precompiled library dependencies are available. These are the quickest way to get a feature complete Blender build, and can be download as follows. 

```bash
mkdir ~/blender-git/lib
cd ~/blender-git/lib
svn checkout https://svn.blender.org/svnroot/bf-blender/trunk/lib/linux_centos7_x86_64
```
