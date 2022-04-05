#!/bin/bash


# ==================================
# Detect Requirements
# ==================================

# Require Bash
if [ -z "${BASH_VERSION:-}" ]
then
  echo "Bash is required to interpret this script."
  exit 1
fi

detect_sudo()
{
    fmt_info "checking sudo..."
    if [[ ! -x "/usr/bin/sudo" ]]; then
        error_exit "You must install sudo first"
        exit 1
    fi
    # check if user can sudo
    if ! sudo -v &> /dev/null ; then
        error_exit "you can not use sudo command, please make sure you have sudo privileges"
        exit 1
    fi
	fmt_info "[ok]"
}

detect_git()
{
	fmt_info "checking git ..."
	if ! command -v git >/dev/null 2>&1; then
		error_exit "Error: You must install git first"
		exit 1
	fi
	fmt_info "[ok]"
}


detect_curl()
{
	fmt_info "checking curl ..."
	if ! command -v curl >/dev/null 2>&1; then
		error_exit "Error: You must install curl first"
		exit 1
	fi
	fmt_info "[ok]"
}

detect_systemd()
{
	fmt_info "check systemd..."
	if [[ -d /run/systemd/system ]] || grep -q systemd <(ls -l /sbin/init)
	then
		:;
	else
		error_exit "only linux distributions using systemd are supported!"
		exit 1
	fi
	fmt_info "[ok]"
}

detect_requirements()
{
    echo_title "Check Requirements"
    detect_sudo
	detect_systemd
	detect_git
	detect_curl
    fmt_success "Check requirements success"
}

detect_requirements
