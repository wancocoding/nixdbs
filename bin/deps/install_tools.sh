#!/usr/bin/env bash

# install some useful tools
# tmux fzf fd ripgrep the_sliver_searcher bat exa tree htop neofetch

install_tools()
{
	echo_title "Install tools..."
	local tools_to_install=(fzf fd ripgrep the_silver_searcher bat exa htop neofetch unrar)
	for ti in "${tools_to_install[@]}"
	do
		fmt_info "install $ti"
		pkg_install_wrapper "$ti"
	done
	fmt_success "install tools finish."
}

append_step "install_tools"
