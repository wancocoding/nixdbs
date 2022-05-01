#!/usr/bin/env bash

install_gvm()
{
	if [ ! -d $HOME/.gvm ] && [ ! -f $HOME/.gvm/scripts/gvm ]; then
		local gvm_install_script="https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer"
		curl -fsSL $gvm_install_script | bash
	fi
	[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
}

install_default_go()
{
	gvm install $GOLANG_DEFAULT_VERSION
	gvm list
}

setup_go_kits()
{
	echo_title "Setup Golang"

	local script_http_proxy=$(get_http_proxy)
	if [ ! -z "${script_http_proxy:-}" ]; then
		export http_proxy="$script_http_proxy"
	fi

	install_gvm

	install_default_go

	unset http_proxy

	fmt_success "Setup Golang finish!"
}


append_step "setup_go_kits"
