# Setup fzf
# ---------
if [[ ! "$PATH" == */home/coco/.local/share/nvim/site/pack/packer/start/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/coco/.local/share/nvim/site/pack/packer/start/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/coco/.local/share/nvim/site/pack/packer/start/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/coco/.local/share/nvim/site/pack/packer/start/fzf/shell/key-bindings.zsh"
