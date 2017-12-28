
## Install with out cloning

```bash
curl -L https://rawgit.com/patriciogonzalezvivo/.dotfiles/master/install_core.sh | bash   
```

## Install cloning this repo

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

* `install_radio.sh`: Software Define Radio apps

* `install_sublime.sh`: Install Sublime Text

* `install_python.sh`: Install Python with env sandboxes

* `install_themes.sh`: Install Ubuntu Themes

* `rpi/install_xfce.sh`: Replace the X11 window manager for Xfce

* `rpi/install_rplay.sh`: Install RPlay

