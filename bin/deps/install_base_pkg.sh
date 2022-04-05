#!/usr/bin/env bash

# check and install some tools
# curl unzip python3 awk

install_base_tools()
{
	echo_title "Install Base Tools (curl,unzip......)"
	fmt_info "Check and install some tools..."
	echo "checking curl..."
	if ! command_exists "curl"; then
		pkg_install "curl"
	else
		echo "curl already installed"
	fi
	echo "checking unzip..."
	if ! command_exists "unzip"; then
		pkg_install "unzip"
	else
		echo "unzip already installed"
	fi
	echo "checking awk..."
	if ! command_exists "awk"; then
		pkg_install "awk"
	else
		echo "awk already installed"
	fi
	echo "checking python3..."
	if ! command_exists "python3"; then
		pkg_install "python3"
	else
		echo "python3 already installed"
	fi

	fmt_success "all base tools pkg has installed"
}


append_step "install_base_tools"
