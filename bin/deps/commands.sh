#!/bin/bash

cmd_to_string()
{
    local exe_arg
    printf "%s" "$1"
    shift
    for exe_arg in "$@"
    do
        printf " "
        # replace all space
        printf "%s" "${exe_arg// /\ }"
    done
}
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

exe_sudo_string()
{
    execute "/usr/bin/sudo" "/bin/bash" "-c" "$*"
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

echo_commands()
{
	fmt_info "package install cmd: ${SYS_INSTALL_PKG_CMD[@]}"
	fmt_info "package sync cmd: ${SYS_UPDATE_CMD[@]}"
	fmt_info "package upgrade cmd: ${SYS_UPGRADE_CMD[@]}"
	fmt_info "package clean cmd: ${SYS_CLEAN_CMD[@]}"
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
    SYS_UPDATE_CMD=("emerge" "--ask" "--sync")
    SYS_UPGRADE_CMD=("emerge" "-avuND" "@world")
    SYS_CLEAN_CMD=("emerge" "-a" "--depclean")
    gentoo_setup_portage_mirror
    gentoo_setup_portage_license


    # fmt_info "Now, test system package manager command!"
    # pkg_install "app-admin/eselect" 
    # system_update
}

# =================================
# Manjaro
# =================================

setup_manjaro_mirror()
{
    fmt_info "Change pacman repos mirror"
	if grep -q tsinghua /etc/pacman.d/mirrorlist ; then
		echo "mirror already existed!"
	else
		echo "mirror server not existed, now add it."
		insert_ln=$(grep -Fn Server /etc/pacman.d/mirrorlist | sed -n  '1p' | cut --delimiter=":" --fields=1)
		exe_sudo "sed" "-i" "'$insert_ln i $MANJARO_MIRROR'" "/etc/pacman.d/mirrorlist"
		unset insert_ln
	fi
}

setup_manjaro()
{
    SYS_INSTALL_PKG_CMD=("pacman" "-Sy")
    SYS_UPGRADE_PKG_CMD=("pacman" "-Sy")
    SYS_UPDATE_CMD=("pacman" "-Syy")
    SYS_UPGRADE_CMD=("pacman" "-Syu")

    # setup mirror
    setup_manjaro_mirror

}


# =================================
# Archlinux
# =================================

setup_arch_mirror()
{
    fmt_info "Change pacman repos mirror"
	if grep -q tsinghua /etc/pacman.d/mirrorlist ; then
		echo "mirror already existed!"
	else
		echo "mirror server not existed, now add it."
		insert_ln=$(grep -Fn Server /etc/pacman.d/mirrorlist | sed -n  '1p' | cut --delimiter=":" --fields=1)
		exe_sudo "sed" "-i" "'$insert_ln i $ARCH_MIRROR'" "/etc/pacman.d/mirrorlist"
		unset insert_ln
	fi
}

setup_arch()
{
    SYS_INSTALL_PKG_CMD=("pacman" "-Sy")
    SYS_UPGRADE_PKG_CMD=("pacman" "-Sy")
    SYS_UPDATE_CMD=("pacman" "-Syy")
    SYS_UPGRADE_CMD=("pacman" "-Syu")

    # setup mirror
    setup_manjaro_mirror

}

# =================================
# Ubuntu
# =================================

setup_ubuntu_mirror()
{
    fmt_info "Change apt repos mirror"
	exe_sudo_string "echo" "'$UBUNTU_MIRROR'" ">" "/etc/apt/sources.list"
}

setup_ubuntu()
{
	fmt_info "Define your system commands"
    SYS_INSTALL_PKG_CMD=("apt" "-y" "--no-install-recommends" "install")
    SYS_UPGRADE_PKG_CMD=("apt" "update")
    SYS_UPDATE_CMD=("apt" "update")
    SYS_UPGRADE_CMD=("apt" "upgrade" "-y")

    # setup mirror
    setup_ubuntu_mirror

}

# =================================

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
			setup_manjaro
            ;;
        arch)
            fmt_info "Your os is ArchLinux!"
			setup_arch
            ;;
        ubuntu)
            fmt_info "Your os is Ubuntu!"
			setup_ubuntu
            ;;
        *)
            error_exit "Sorry, $OSNAME_LOWERCASE is not supported right now."
            ;;
    esac
	echo_commands
	fmt_success "Setup system commands finish!"
}

setup_os_commands
