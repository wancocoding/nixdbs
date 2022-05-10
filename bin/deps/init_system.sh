#!/bin/bash

# update system package manager and install some basic software


system_update()
{
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


init_system()
{
	echo_title "Update your system!"
	system_update
}


append_step "init_system"

exec_update_sys()
{
	echo_title "Upgrade System!"
	system_update
	fmt_success "Update system finish!"
}
