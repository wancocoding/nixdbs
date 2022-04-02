#!/usr/bin/env bash

# ==================================
# Setup Development kits
# ==================================

setup_basic_dev_kits()
{
    echo_title "Install base develop packages"    
    if [ "${OS}" = "Linux" ] ; then
       if [[ -x "$(command -v apt)" ]] ; then
           fmt_info "Debian install build-essential"
           exe_sudo_string "apt install build-essential"
       elif command -v pacman > /dev/null ; then
           fmt_info "Arch install base-devel"
           exe_sudo_string "pacman -Syu base-devel"
       elif command -v dnf > /dev/null ; then
           fmt_info "dnf group install [Development Tools] and [Development Libraries]"
           exe_sudo_string 'dnf group install "Development Tools" "Development Libraries"'
       elif command -v yum > /dev/null ; then
           fmt_info "yum group install [Development Tools] and [Development Libraries]"
           exe_sudo_string 'yum groupinstall "Development Tools" "Development Libraries"'
       elif command -v zypper > /dev/null ; then
           fmt_info "Suse sudo zypper install -t pattern devel_basis"
           exe_sudo_string "zypper install -t pattern devel_basis"
       elif command -v apk > /dev/null; then
           fmt_info "Alpine install build-base"
           exe_string_string "apk add build-base"
	   elif command -v emerge >/dev/null 2>&1; then
		   fmt_warning "Gentoo linux do not need build essential!"
       else
           error_exit "Your OS not support now!"
       fi
    elif [ "${OS}" == "Darwin" ]; then
        fmt_info "execute 'xcode-select --install' on macosx"
        xcode-select --install
    else
		error_exit "Your OS not support now!"
    fi
	fmt_success "Setup base dev kits finish!"
}

setup_basic_dev_kits
