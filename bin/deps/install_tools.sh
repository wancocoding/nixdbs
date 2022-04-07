#!/usr/bin/env bash

# install some useful tools
# tmux fzf fd ripgrep the_sliver_searcher bat exa tree htop neofetch

install_tools()
{
	echo_title "Install tools..."
	local install_tools=(bat exa htop neofetch unrar)
	for ti in "${install_tools[@]}"
	do
		fmt_info "install $ti"
		pkg_install_wrapper "$ti"
	done
	fmt_success "install tools finish."
}


append_step "install_tools"
