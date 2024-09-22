
## Install with out cloning

```bash
curl -L https://rawgit.com/patriciogonzalezvivo/.dotfiles/main/install_core.sh | bash   
```

## Install by cloning this repo

1. Install `git` 

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
```

## Other install scripts

* `install_tool.sh`: Install desktop apps like Inkscape, Gimp, blender, etc

* `install_net.sh`: Install basic network tools

* `install_sdr.sh`: Software Define Radio apps

* `install_python.sh`: Install Python with env sandboxes

* `install_of.sh`: Install OpenFrameworks, my project and the addons I use the most


## Raspberry Pi specific scripts

* `rpi/install_xfce.sh`: Replace the X11 window manager for Xfce

* `rpi/install_rplay.sh`: Install RPlay

* `rpi/install_gpsd.sh`: Install GPS device

* `rpi/install_hotspot.sh`: Install Automatic HotSpot deamon. In case of using Buster distribution use: `install_hotspot_buster.sh`

## Hardware Specific documentation

* [Razer Blade Stealth late 2019](doc/razer_blade_stealth_2019.md)

* [RaspberryPi Zero controlling Celestron Telescope](doc/Rpi_zero_telescope.md)

* [MacBook Pro](doc/mac_book_pro.md)


