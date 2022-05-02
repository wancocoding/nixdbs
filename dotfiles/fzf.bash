# fzf bash completion and key bindings
if [[ $- == *i* ]];then
	[[ -f /usr/share/bash-completion/completions/fzf ]] && source /usr/share/bash-completion/completions/fzf
	[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
fi
