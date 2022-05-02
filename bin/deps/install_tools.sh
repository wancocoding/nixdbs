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

install_tools()
{
	echo_title "Install tools..."
	local tools_to_install=(fzf fd ripgrep the_silver_searcher bat exa htop \
		neofetch unrar zip unzip)
	for ti in "${tools_to_install[@]}"
	do
		fmt_info "install $ti"
		pkg_install_wrapper "$ti"
	done
	config_fzf
	fmt_success "install tools finish."
}

append_step "install_tools"
