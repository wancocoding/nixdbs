#!/bin/bash

# update system package manager and install some basic software

system_update() {
    fmt_info "Update your system"
    if [ -v SYS_SYNC_CMD[@] ]; then
        exe_sudo "${SYS_SYNC_CMD[@]}"
    fi
    if [ -v SYS_UPGRADE_CMD[@] ]; then
        exe_sudo "${SYS_UPGRADE_CMD[@]}"
    fi
    if [ -v SYS_CLEAN_CMD[@] ]; then
        exe_sudo "${SYS_CLEAN_CMD[@]}"
    fi
}

system_clean() {
    if [ -v SYS_CLEAN_CMD[@] ]; then
        exe_sudo "${SYS_CLEAN_CMD[@]}"
    fi
}

exec_install_sys() {
    echo_title "Update your system!"
    system_update
    fmt_success "Update system finish!"
}

append_task_to_init "sys"

exec_update_sys() {
    echo_title "Upgrade System!"
    system_update
    fmt_success "Update system finish!"
}
