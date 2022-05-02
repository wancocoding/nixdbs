# fzf zsh completion and key bindings
if [[ $- == *i* ]];then
	[[ -f /usr/share/zsh-completion/completions/fzf ]] && source /usr/share/zsh-completion/completions/fzf
	[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
fi

