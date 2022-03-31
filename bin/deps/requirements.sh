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
        echo "You must install sudo first"
        exit 1
    fi
    # check if user can sudo
    if ! sudo -v &> /dev/null ; then
        echo "Error: you can not use sudo command, please make sure you have sudo privileges"
        exit 1
    fi
}

detect_systemd()
{
	fmt_info "check systemd..."
	if [[  -d /run/systemd/system ]] || grep -q systemd < (ls -l /sbin/init);
	then
		:;
	else
		echo "Error: only linux distributions using systemd are supported!"
		exit 1
	fi
}

detect_requirements()
{
    echo_title "Check Requirements"
    detect_sudo
	detect_systemd
    fmt_success "Check requirements success"
}

detect_requirements
