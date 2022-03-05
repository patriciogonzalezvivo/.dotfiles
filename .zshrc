# User configuration
export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export CF_LIBRARY_PATH=$CF_LIBRARY_PATH:/usr/local/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export INCLUDE=/usr/local/include:/usr/include
export LIBDIR=/usr/local/lib:/usr/lib
export MANPATH=/usr/local/man:$MANPATH
#export HOMEBREW_BUILD_FROM_SOURCE=1

# MAC
if [ -d /opt/homebrew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gallois"
plugins=(git git-extras tmux python pip vscode colored-man-pages themes sudo)

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

source $ZSH/oh-my-zsh.sh

# MacLatex
if [ -d /usr/local/texlive/2015/bin/x86_64-darwin ]; then
    export PATH=/usr/local/texlive/2015/bin/x86_64-darwin:$PATH
fi

if [ -d /Library/TeX/texbin ]; then
    export PATH=/Library/TeX/texbin:$PATH
fi

# GO
if [ -d ~/gocode ]; then
    export GOPATH=~/gocode
    export PATH=$GOPATH/bin:$PATH
fi

# Cargo
if [ -d ~/.cargo/bin ]; then
    export PATH=~/.cargo/bin:$PATH
fi

# Android
if [ -d /opt/Android ]; then
    ANDROID_HOME="/opt/Android"
    JAVA_HOME="$ANDROID_HOME/JDK/jdk-11.0.8+10"
    export JAVA_HOME
    export ANDROID_HOME
    export PATH="$JAVA_HOME/bin:$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools:$PATH"
fi

# NVM ( Node.js )
if [ -d ~/.nvm ]; then
    export NVM_DIR="/home/patricio/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
fi

# LOCAL setup
if [ -f ~/.localrc ]; then
    source ~/.localrc
fi 

# VSCode
if [ -f /usr/bin/code ]; then
    alias vs="code --disable-gpu"
fi

if [ -f /usr/bin/gnuradio-companion ]; then
    alias gnuradio-companion="env PYTHONPATH=$PYTHONPATH:/usr/lib/python3/dist-packages:/usr/local/lib/python3/dist-packages gnuradio-companion"
fi

if [ -f /home/patricio/Applications/Blender/blender ]; then
   alias Blender="PYTHONPATH=/usr/local/lib/python3.8/dist-packages/ /home/patricio/Applications/Blender/./blender --python-use-system-env"
fi

#if [ -d /usr/local/lib/python3/dist-packages ]; then
#    export PYTHONPATH=$PYTHONPATH:/usr/lib/python3/dist-packages:/usr/local/lib/python3/dist-packages
#fi
# added by travis gem
[ ! -s /home/patricio/.travis/travis.sh ] || source /home/patricio/.travis/travis.sh
