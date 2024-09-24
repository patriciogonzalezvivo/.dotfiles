# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/patricio/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/patricio/.fzf/bin"
fi

source <(fzf --zsh)
