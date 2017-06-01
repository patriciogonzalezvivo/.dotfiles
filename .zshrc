export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gallois"
plugins=(git git-extras vim tmux brew)

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# User configuration
export PATH=/usr/local/share/python:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export CF_LIBRARY_PATH=$CF_LIBRARY_PATH:/usr/local/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export INCLUDE=/usr/local/include:/usr/include
export LIBDIR=/usr/local/lib:/usr/lib
#export CFLAGS="-I/usr/local/include -L/usr/local/lib"
#export LDFLAGS="-L/usr/local/lib"
export MANPATH=/usr/local/man:$MANPATH
source $ZSH/oh-my-zsh.sh

# MacLatex
if [ -d /usr/local/texlive/2015/bin/x86_64-darwin ]; then
    export PATH=/usr/local/texlive/2015/bin/x86_64-darwin:$PATH
fi

if [ -d /Library/TeX/texbin ]; then
    export PATH=/Library/TeX/texbin:$PATH
fi

# FB
if [ -d /opt/facebook ]; then
    export PATH=/opt/facebook/bin:/opt/facebook/hg/bin:$PATH
fi

# CUDA SDK
if [ -d /usr/local/cuda ]; then
    #export PATH=/usr/local/cuda/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH
    export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:$DYLD_LIBRARY_PATH
fi

# Andorid SDK
if [ -d /Developer/android-sdk-macosx ]; then
    export PATH=${PATH}:/Developer/android-sdk-macosx/platform-tools:/Developer/android-sdk-macosx/tools
    export ANDROID_HOME=/Developer/android-sdk-macosx
fi
if [ -d /Developer/android-ndk-r10 ]; then
    export PATH=${PATH}:/Developer/android-ndk-r10 
    export ANDROID_NDK=/Developer/android-ndk-r10  
fi

# PYTHON virtualenv and virtualenvwrapper
if [ -d $HOME/.virtualenvs ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
    #export PYTHONPATH=/usr/local/lib/python2.7:$PYTHONPATH
fi

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias rmake='make -j 8 CXX=/usr/lib/distcc/arm-linux-gnueabihf-g++ CC=/usr/lib/distcc/arm-linux-gnueabihf-gcc'

export NVM_DIR="/home/patricio/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
