#!/usr/bin/env bash

# install some useful tools
# tmux fzf fd ripgrep the_sliver_searcher bat exa tree htop neofetch



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
		fi
	fi

	if [ -f $HOME/.bashrc ]; then
		if ! grep -q "FZF_DEFAULT_COMMAND" $HOME/.bashrc ;then
			echo "" >> $HOME/.bashrc
			echo "# ====== fzf settings ======" >> $HOME/.bashrc
			echo "$FZF_SETTINGS" >> $HOME/.bashrc
			echo "$FZF_SETTINGS_CONS" >> $HOME/.bashrc
			cat $NIXDBS_HOME/dotfiles/fzf.bash >> $HOME/.bashrc
		fi
	fi
}

get_fzf_shell_tools()
{
	fmt_info "download fzf completion and key-bnindings..."
	local fzf_shell_location="$HOME/.local/share/shell/fzf"
	[ -d $fzf_shell_location ] && rm -rf $fzf_shell_location > /dev/null 2>&1
	mkdir -p "$fzf_shell_location" > /dev/null 2>&1
	curl -o "$fzf_shell_location/completion.bash" -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash
	curl -o "$fzf_shell_location/key-bindings.bash" -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash
	curl -o "$fzf_shell_location/completion.zsh" -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
	curl -o "$fzf_shell_location/key-bindings.zsh" -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
}

install_cheatsh()
{
	if [ ! -f $HOME/.local/bin/cht.sh ];then 
		[ ! -f $HOME/.local/bin ] && rm -rf $HOME/.local/bin/cht.sh > /dev/null 2>&1
		curl https://cht.sh/:cht.sh > $HOME/.local/bin/cht.sh
		chmod +x $HOME/.local/bin/cht.sh
	fi

	# shell completion
	local cht_shell_location="$HOME/.local/share/shell/cht"
	[ -d $cht_shell_location ] && rm -rf $cht_shell_location > /dev/null 2>&1
	mkdir -p "$cht_shell_location" > /dev/null 2>&1
	curl -o "$cht_shell_location/completion.bash" -L \
		https://cheat.sh/:bash_completion
	append_rc "[ -f $cht_shell_location/completion.bash ] && source $cht_shell_location/completion.bash"
}

install_tools()
{
	echo_title "Install tools..."
	# http_proxy
	local script_http_proxy=$(get_http_proxy)
	if [ ! -z "${script_http_proxy:-}" ]; then
		export http_proxy="$script_http_proxy"
	fi
	local tools_to_install=(fzf fd ripgrep the_silver_searcher bat exa htop \
		neofetch unrar zip unzip)
	for ti in "${tools_to_install[@]}"
	do
		fmt_info "install $ti"
		pkg_install_wrapper "$ti"
	done
	get_fzf_shell_tools
	config_fzf

	install_cheatsh

	unset http_proxy
	fmt_success "install tools finish."
}

append_step "install_tools"
