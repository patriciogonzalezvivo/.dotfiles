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
    # eval "$(/opt/homebrew/bin/brew shellenv)"
    export INCLUDE=/opt/homebrew/include:$INCLUDE
    export LIBDIR=/opt/homebrew/lib:$LIBDIR
    export PATH=/opt/homebrew/sbin:/opt/homebrew/bin:$PATH
    export CF_LIBRARY_PATH=/opt/homebrew/Frameworks/Python.framework/Versions/3.9/include/python3.9:/opt/homebrew/include:$CF_LIBRARY_PATH
    export LD_LIBRARY_PATH=/opt/homebrew/Frameworks/Python.framework/Versions/3.9/lib:/opt/homebrew/lib:$LD_LIBRARY_PATH
fi

if [ -d ~/.local/bin ]; then
    export PATH=~/.local/bin:$PATH
fi


export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gallois"
plugins=(git git-extras tmux python pip brew vscode colored-man-pages themes sudo fzf-zsh-plugin)

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

# Conda
if [ -d ~/miniconda3 ]; then
    source $HOME/miniconda3/bin/activate  # commented out by conda initialize
fi

# Local bin
if [ -d ~/.local/bin ]; then
     export PATH=~/.local/bin:$PATH
fi

# Cargo
if [ -d ~/.cargo/bin ]; then
    export PATH=~/.cargo/bin:$PATH
fi

if [ -d /opt/gradle ]; then
    export PATH=$PATH:/opt/gradle/bin
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
if command -v code &> /dev/null
then
    alias vs="code --disable-gpu"
fi

if [ -f /usr/bin/gnuradio-companion ]; then
    alias gnuradio-companion="env PYTHONPATH=$PYTHONPATH:/usr/lib/python3/dist-packages:/usr/local/lib/python3/dist-packages gnuradio-companion"
fi

if [ -f ~/Applications/Blender/blender ]; then
   alias Blender_python="PYTHONPATH=/usr/local/lib/python3.10/dist-packages ~/Applications/Blender/./blender --python-use-system-env"
   alias Blender="~/Applications/Blender/./blender"
fi

#if [ -d /usr/local/lib/python3/dist-packages ]; then
#    export PYTHONPATH=$PYTHONPATH:/usr/lib/python3/dist-packages:/usr/local/lib/python3/dist-packages
#fi

if [ -d /usr/local/cuda ]; then
   export PATH="/usr/local/cuda/bin:$PATH"
   export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
fi


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -d /Users/patricio/miniconda3 ]; then
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/patricio/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/patricio/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/patricio/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/patricio/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
fi 
# <<< conda initialize <<<

if [ -f  ~/.ssh/id_ed25519 ]; then
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
fi
