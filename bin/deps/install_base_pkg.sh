#!/usr/bin/env bash

# check and install some tools
# curl unzip python3 awk

exec_install_base()
{
	echo_title "Install Base Tools (curl,unzip......)"
	fmt_info "Check and install some tools..."
	echo "checking curl..."
	if ! command_exists "curl"; then
		pkg_install_wrapper "curl"
		record_task "base" "ins" "$(pkg_install_info curl)"
	else
		echo "curl already installed"
	fi
	echo "checking unzip..."
	if ! command_exists "unzip"; then
		pkg_install "unzip"
		record_task "base" "ins" "$(pkg_install_info unzip)"
	else
		echo "unzip already installed"
	fi
	echo "checking awk..."
	if ! command_exists "awk"; then
		pkg_install "awk"
		record_task "base" "ins" "$(pkg_install_info awk)"
	else
		echo "awk already installed"
	fi
	echo "checking python3..."
	if ! command_exists "python3"; then
		pkg_install "python3"
		record_task "base" "ins" "$(pkg_install_info python3)"
	else
		echo "python3 already installed"
	fi

	fmt_success "all base tools pkg has installed"
}

exec_update_base()
{
	echo_title "Update Base packages."
	fmt_info "update curl unzip awk python3"
	pkg_update_wrapper "curl" "unzip" "awk" "sed" "python3"
	fmt_success "update base packages finish"
}

append_task_to_init "base"

