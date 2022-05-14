#!/usr/bin/env bash

# install some useful tools
# tmux fzf fd ripgrep the_sliver_searcher bat exa tree htop neofetch


global_utility_tools=(fzf fd ripgrep the_silver_searcher bat exa htop \
	neofetch unrar zip unzip)

config_fzf()
{
	fmt_info "setup fzf..."
	if [ -f $HOME/.zshrc ]; then
		if ! grep -q "FZF_DEFAULT_COMMAND" $HOME/.zshrc ;then
			echo "" >> $HOME/.zshrc
			echo "# ====== fzf settings ======" >> $HOME/.zshrc
			echo "$FZF_SETTINGS" >> $HOME/.zshrc
			echo "$FZF_SETTINGS_CONS" >> $HOME/.zshrc
			cat $NIXDBS_HOME/dotfiles/fzf.zsh >> $HOME/.zshrc
			record_task "dev_tools" "rc" "# ====== fzf settings ======"
			record_task "dev_tools" "rc" "$FZF_SETTINGS"
			record_task "dev_tools" "rc" "$FZF_SETTINGS_CONS"
			record_task "dev_tools" "rc" "$(cat $NIXDBS_HOME/dotfiles/fzf.zsh)"
		fi
	fi

	if [ -f $HOME/.bashrc ]; then
		if ! grep -q "FZF_DEFAULT_COMMAND" $HOME/.bashrc ;then
			echo "" >> $HOME/.bashrc
			echo "# ====== fzf settings ======" >> $HOME/.bashrc
			echo "$FZF_SETTINGS" >> $HOME/.bashrc
			echo "$FZF_SETTINGS_CONS" >> $HOME/.bashrc
			cat $NIXDBS_HOME/dotfiles/fzf.bash >> $HOME/.bashrc
			record_task "dev_tools" "rc" "# ====== fzf settings ======"
			record_task "dev_tools" "rc" "$FZF_SETTINGS"
			record_task "dev_tools" "rc" "$FZF_SETTINGS_CONS"
			record_task "dev_tools" "rc" "$(cat $NIXDBS_HOME/dotfiles/fzf.bash)"
		fi
	fi

}


get_fzf_shell_tools()
{
	shopt -s expand_aliases
	fmt_info "download fzf completion and key-bnindings..."
	local fzf_shell_location="$HOME/.local/share/shell/fzf"
	[ -d $fzf_shell_location ] && rm -rf $fzf_shell_location > /dev/null 2>&1
	mkdir -p "$fzf_shell_location" > /dev/null 2>&1
	fmt_info "downlad bash completion"
	curl_wrapper -o "$fzf_shell_location/completion.bash" -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash
	fmt_info "downlad bash key-bindings"
	curl_wrapper -o "$fzf_shell_location/key-bindings.bash" -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash
	fmt_info "downlad zsh completion"
	curl_wrapper -o "$fzf_shell_location/completion.zsh" -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
	fmt_info "downlad zsh key-bindings"
	curl_wrapper -o "$fzf_shell_location/key-bindings.zsh" -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
}

exec_install_cheatsh()
{
	echo_title "Installing cheat.sh ..."
	use_http_proxy_by_setting "install_dev_tools"
	if [ ! -f $HOME/.local/bin/cht.sh ];then 
		[ ! -f $HOME/.local/bin ] && rm -rf $HOME/.local/bin/cht.sh > /dev/null 2>&1
		fmt_info "downloading cht.sh ..."
		curl_wrapper https://cht.sh/:cht.sh > $HOME/.local/bin/cht.sh
		chmod +x $HOME/.local/bin/cht.sh
		record_task "cheatsh" "file" "$HOME/.local/bin/cht.sh"
	fi

	# shell completion
	# bash
	local cht_shell_location="$HOME/.local/share/shell/cht"
	[ -d $cht_shell_location ] && rm -rf $cht_shell_location > /dev/null 2>&1
	mkdir -p "$cht_shell_location" > /dev/null 2>&1
	fmt_info "downloading cheat.sh bash completion ..."
	curl_wrapper -o "$cht_shell_location/completion.bash" -l \
		https://cheat.sh/:bash_completion
	record_task "cheatsh" "file" "$cht_shell_location/completion.bash"
	append_bashrc "# cheat.sh bash completion"
	append_bashrc "[ -f $cht_shell_location/completion.bash ] && source $cht_shell_location/completion.bash"
	record_task "cheatsh" "rc" "# cheat.sh bash completion"
	record_task "cheatsh" "rc" "[ -f $cht_shell_location/completion.bash ] && source $cht_shell_location/completion.bash"

	# zsh
	mkdir -p $HOME/.zsh.d > /dev/null 2>&1
	fmt_info "downloading cheat.sh zsh completion ..."
	[ -f $HOME/.zsh.d/_cht ] && rm $HOME/.zsh.d/_cht 
	curl_wrapper -o "$HOME/.zsh.d/_cht" -SL https://cheat.sh/:zsh
	record_task "cheatsh" "file" "$HOME/.zsh.d/_cht"
	append_zshrc "# cheat.sh zsh completion"
	append_zshrc 'fpath=(~/.zsh.d/ $fpath)'
	record_task "cheatsh" "rc" "# cheat.sh zsh completion"
	record_task "cheatsh" "rc"  'fpath=(~/.zsh.d/ $fpath)'
	unset_http_proxy
	fmt_success "install cheat.sh finish!"
}

exec_install_tldr()
{
	echo_title "Install tldr ..."
	# setup node first
	fmt_info "setup node and nvm first ..."
	dependent_tasks "node"
	fmt_info "install tldr by npm"
	npm install -g tldr
	record_task "tldr" "ins" "tldr,npm,npm install -g tldr"
	record_task "tldr" "file" "$(get_bin_path tldr)"
	fmt_info "install tldr finish!"
	tldr -v
	tldr -l
}

exec_install_dev_tools()
{
	echo_title "Install tools..."
	for ti in "${global_utility_tools[@]}"
	do
		fmt_info "install $ti"
		pkg_install_wrapper "$ti"
		record_task "dev_tools" "ins" "$(get_pkg_install_cmd_text $ti)"
	done
	get_fzf_shell_tools
	config_fzf
	
	fmt_success "install tools finish."
}

append_task_to_init "dev_tools"
append_task_to_init "tldr"
append_task_to_init "cheatsh"

exec_update_tools()
{
	echo_title "update tools"

	for ti in "${global_utility_tools[@]}"
	do
		fmt_info "update $ti"
		pkg_update_wrapper "$ti"
	done
	fmt_success "update utility tools finish!"
}

exec_update_tldr()
{
	echo_title "update tldr"

	if ! command -v tldr;then
		error_exit "tldr not installed yet!"
	fi

	npm update -g tldr

	fmt_success "update utility tools finish!"

}

exec_update_cheatsh()
{
	fmt_warning "no need to upgrade cheat.sh"
}
