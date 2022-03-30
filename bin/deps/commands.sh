#!/bin/bash

execute()
{
    fmt_cmd "$*"
    if ! "$@"; then
        fmt_error "when excute command: $*"
    fi
}

exe_sudo()
{
    local -a args=("$@")
    execute "/usr/bin/sudo" "${args[@]}"
}


pkg_install()
{
    if [ -v $SYS_INSTALL_CMD ]; then
        error_exit "$OSNAME_LOWERCASE system install command not set correctlly!"
    fi

    declare -a install_cmd=()

    for sys_install_cmd_arg in "${SYS_INSTALL_CMD[@]}"
    do
        install_cmd+=("$sys_install_cmd_arg")
    done
    
    for install_arg in "$@"
    do
        install_cmd+=("$install_arg")
    done
    exe_sudo "${install_cmd[@]}"
}

system_update()
{
    fmt_info "Update your system"
    if [ -v SYS_UPDATE_CMD[@] ]; then
        exe_sudo "${SYS_UPDATE_CMD[@]}"
    fi
    if [ -v SYS_UPGRADE_CMD[@] ]; then
        exe_sudo "${SYS_UPGRADE_CMD[@]}"
    fi
    if [ -v SYS_CLEAN_CMD[@] ]; then
        exe_sudo "${SYS_CLEAN_CMD[@]}"
    fi
}

# =================================
# Gentoo
# =================================

gentoo_setup_portage_mirror()
{
    # change the package manager mirror
    fmt_info "Change portage repos mirror"
    if [ -f /etc/portage/repos.conf/gentoo.conf ]; then
        replace_cmd=("sed" "-i" "/^sync-uri /s/=.*/= rsync:\/\/rsync.mirrors.ustc.edu.cn\/gentoo-portage\//" "/etc/portage/repos.conf/gentoo.conf")
        exe_sudo "${replace_cmd[@]}"
    fi
    # change the gentoo mirror
    fmt_info "Change portage make conf"
    replace_cmd=("sed" "-i" "/^GENTOO_MIRRORS/s/=.*$/=\"https:\/\/mirrors.ustc.edu.cn\/gentoo\/\"/" "/etc/portage/make.conf")
    exe_sudo "${replace_cmd[@]}"
}

gentoo_setup_portage_license()
{
    fmt_info "Update portage accept license"
    if grep -q "ACCEPT_LICENSE" /etc/portage/make.conf ; then
        replace_cmd=("sed" "-i" "/^ACCEPT_LICENSE/s/=.*$/=\"*\"/" "/etc/portage/make.conf")
        exe_sudo "${replace_cmd[@]}"
    else
        replace_cmd=("sed" "-i" '$aACCEPT_LICENSE=\"*\"' "/etc/portage/make.conf") 
        exe_sudo "${replace_cmd[@]}"
    fi
}

setup_gentoo()
{
    SYS_INSTALL_PKG_CMD=("emerge" "-av")
    SYS_UPGRADE_PKG_CMD=("emerge" "--update" "--deep" "--change-use")
    # SYS_UPDATE_CMD=("emerge" "--ask" "--sync")
    # SYS_UPGRADE_CMD=("emerge" "-avuND" "@world")
    SYS_CLEAN_CMD=("emerge" "-a" "--depclean")
    gentoo_setup_portage_mirror
    gentoo_setup_portage_license

	system_update

    # fmt_info "Now, test system package manager command!"
    # pkg_install "app-admin/eselect" 
    # system_update
}


setup_os_commands()
{
    echo_title "Setup system commands"
    case $OSNAME_LOWERCASE in
        gentoo)
            fmt_info "Your os is Gentoo Linux!"
            setup_gentoo
            ;;
        manjaro)
            fmt_info "Your os is Manjaro Linux!"
            ;;
        *)
            error_exit "Sorry, $OSNAME_LOWERCASE is not supported right now."
            ;;
    esac
}

setup_os_commands
