#!/usr/bin/env bash

# ==================================
# Setup Development kits
# ==================================

exec_install_dev_basic() {
    echo_title "Install base develop packages"
    if [ "${OS}" = "Linux" ]; then
        if [[ -x "$(command -v apt)" ]]; then
            fmt_info "Debian install build-essential"
            exe_sudo_string "apt -y install build-essential"
            record_task "dev_basic" "ins" "build-enssential,sys,apt install build-essential"
        elif command -v pacman >/dev/null; then
            fmt_info "Arch install base-devel"
            exe_sudo_string "pacman -Syu base-devel"
            record_task "dev_basic" "ins" "base-devel,sys, pacman -Syu base-devel"
        elif command -v dnf >/dev/null; then
            fmt_info "dnf group install [Development Tools] and [Development Libraries]"
            exe_sudo_string 'dnf group install "Development Tools" "Development Libraries"'
            record_task "dev_basic" "ins" "Development Tools,sys,dnf group install [Development Tools]"
            record_task "dev_basic" "ins" "Development Tools,sys,dnf group install [Development Libraries]"
        elif command -v yum >/dev/null; then
            fmt_info "yum group install [Development Tools] and [Development Libraries]"
            exe_sudo_string 'yum groupinstall "Development Tools" "Development Libraries"'
            record_task "dev_basic" "ins" "Development Tools,sys,yum group install [Development Tools]"
            record_task "dev_basic" "ins" "Development Tools,sys,yum group install [Development Libraries]"
        elif command -v zypper >/dev/null; then
            fmt_info "Suse sudo zypper install -t pattern devel_basis"
            exe_sudo_string "zypper install -t pattern devel_basis"
            record_task "dev_basic" "ins" "devel_basis,sys,zypper install -t pattern devel_basis"
        elif command -v apk >/dev/null; then
            fmt_info "Alpine install build-base"
            exe_string_string "apk add build-base"
            record_task "dev_basic" "ins" "build-base,sys,apk add build-base"
        elif command -v emerge >/dev/null 2>&1; then
            fmt_warning "Gentoo linux do not need build essential!"
        else
            error_exit "Your OS not support now!"
        fi
    elif [ "${OS}" == "Darwin" ]; then
        fmt_info "execute 'xcode-select --install' on macosx"
        xcode-select --install
        record_task "dev_basic" "ins" "xcode-select,sys,xcode-select --install"
    else
        error_exit "Your OS not support now!"
    fi
    fmt_success "Setup base dev kits finish!"
}

append_task_to_init "dev_basic"
