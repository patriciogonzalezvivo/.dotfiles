# Setup fzf
# ---------
if [[ ! "$PATH" == */home/patricio/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/patricio/.fzf/bin"
fi

source <(fzf --zsh)
