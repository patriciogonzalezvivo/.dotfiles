export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gallois"
plugins=(git git-extras tmux sublime pip vscode)

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

# User configuration
export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export CF_LIBRARY_PATH=$CF_LIBRARY_PATH:/usr/local/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export INCLUDE=/usr/local/include:/usr/include
export LIBDIR=/usr/local/lib:/usr/lib
export MANPATH=/usr/local/man:$MANPATH
#export HOMEBREW_BUILD_FROM_SOURCE=1

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

# GO
if [ -d ~/gocode ]; then
    export GOPATH=~/gocode
    export PATH=$GOPATH/bin:$PATH
fi

# Cargo
if [ -d ~/.cargo/bin ]; then
    export PATH=~/.cargo/bin:$PATH
fi

# Local bin
#if [ -d ~/.local/bin ]; then
    #export PATH=~/.local/bin:$PATH
#fi

# ANACONDA
if [ -d /opt/anaconda3/bin]; then
    export PATH=/opt/anaconda3/bin:$PATH
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

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/opt/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

