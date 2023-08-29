#!/bin/bash

cmd_to_string() {
    local exe_arg
    printf "%s" "$1"
    shift
    for exe_arg in "$@"; do
        printf " "
        # replace all space
        printf "%s" "${exe_arg// /\ }"
    done
}
execute() {
    fmt_cmd "$*"
    if ! "$@"; then
        fmt_error "when excute command: $*"
        error_exit "run command failed, now exit."
    fi
}

exe_sudo() {
    local -a args=("$@")
    execute "/usr/bin/sudo" "${args[@]}"
}

exe_sudo_string() {
    # execute "/usr/bin/sudo" "/bin/bash" "-c" "$*"
    fmt_cmd "/usr/bin/sudo" "/bin/bash" "-c" "$*"
    /usr/bin/sudo /bin/bash -c "$*"
    if [[ "$?" -ne '0' ]]; then
        error_exit "when execute sudo bash -c command."
    fi
}

# this will install packages via different ways, system pm or brew or manually
pkg_install_wrapper() {
    # get package meta from json file
    # get teh package install meta
    local osname=$OSNAME_LOWERCASE
    fmt_info "install $1 in $osname"
    # local pkg_query_text="import sys, json; print(json.load(sys.stdin)['$1']['$osname'])"
    # local name_query_text="import sys, json; print(json.load(sys.stdin)['$1']['$osname']['name'])"
    # local method_query_text="import sys, json; print(json.load(sys.stdin)['$1']['$osname']['method'])"
    # cat ./data/pkg_meta.json | python3 -c "$pkg_query_text" >/dev/null 2>&1
    local query_result="$(python3 ${NIXDBS_HOME}/bin/jq.py --os=$osname --pkg=$1)"
    if [[ "$query_result" = "none" ]]; then
        fmt_warning "package meta not exist, now try use system package manager"
        # try to install pkg by system package manager
        pkg_install "$1"
    else
        fmt_info "find package meta: $query_result"
        # get the packages
        local pkg_name=$(echo $query_result | awk '{$NF=""}1' | sed 's/[[:blank:]]*$//')
        local pkg_install_method=$(echo $query_result | awk '{print $NF}')
        fmt_info "install $pkg_name by $pkg_install_method"
        if [ "$pkg_install_method" = "system" ]; then
            local pkg_arr_arg=($pkg_name)
            pkg_install "${pkg_arr_arg[@]}"
        elif [[ "$pkg_install_method" = "brew" ]]; then
            local pkg_arr_arg=($pkg_name)
            brew_install "${pkg_arr_arg[@]}"
        elif [[ "$pkg_install_method" = "manual_compile" ]]; then
            echo "install by manual not implement yet!"
            error_exit "can not install $pkg_name manually"
        else
            error_exit "install method: ${pkg_install_method} not supported!"
        fi
    fi
}

# get install type
pkg_install_info() {
    local osname=$OSNAME_LOWERCASE
    local query_result="$(python3 ${NIXDBS_HOME}/bin/jq.py --os=$osname --pkg=$1)"
    if [[ "$query_result" = "none" ]]; then
        echo "${1},sys,$(get_pkg_install_cmd_text) $1"
    else
        local pkg_name=$(echo $query_result | awk '{$NF=""}1' | sed 's/[[:blank:]]*$//')
        local pkg_install_method=$(echo $query_result | awk '{print $NF}')
        if [ "$pkg_install_method" = "system" ]; then
            echo "${1},sys,$(get_pkg_install_cmd_text) $1"
        elif [[ "$pkg_install_method" = "brew" ]]; then
            echo "${1},homebrew,$(get_brew_install_info) $1"
        elif [[ "$pkg_install_method" = "manual_compile" ]]; then
            echo "${1},manual"
        else
            echo "error"
            exit 1
        fi
    fi
}

pkg_update_wrapper() {
    # get package meta from json file
    # get teh package install meta
    local osname=$OSNAME_LOWERCASE
    fmt_info "upgrade $1 in $osname"
    # local pkg_query_text="import sys, json; print(json.load(sys.stdin)['$1']['$osname'])"
    # local name_query_text="import sys, json; print(json.load(sys.stdin)['$1']['$osname']['name'])"
    # local method_query_text="import sys, json; print(json.load(sys.stdin)['$1']['$osname']['method'])"
    # cat ./data/pkg_meta.json | python3 -c "$pkg_query_text" >/dev/null 2>&1
    local query_result="$(python3 ${NIXDBS_HOME}/bin/jq.py --os=$osname --pkg=$1)"
    if [[ "$query_result" = "none" ]]; then
        fmt_warning "package meta not exist, now try use system package manager"
        # try to install pkg by system package manager
        pkg_update "$1"
    else
        fmt_info "find package meta: $query_result"
        # get the packages
        local pkg_name=$(echo $query_result | awk '{$NF=""}1' | sed 's/[[:blank:]]*$//')
        local pkg_update_method=$(echo $query_result | awk '{print $NF}')
        fmt_info "update $pkg_name by $pkg_update_method"
        if [ "$pkg_update_method" = "system" ]; then
            local pkg_arr_arg=($pkg_name)
            pkg_update "${pkg_arr_arg[@]}"
        elif [[ "$pkg_update_method" = "brew" ]]; then
            local pkg_arr_arg=($pkg_name)
            brew_upgrade "${pkg_arr_arg[@]}"
        elif [[ "$pkg_update_method" = "manual_compile" ]]; then
            echo "update by manual not implement yet!"
            error_exit "can not update $pkg_name manually"
        else
            error_exit "update method: ${pkg_update_method} not supported!"
        fi
    fi
}

pkg_remove_wrapper() {
    # get package meta from json file
    # get teh package install meta
    local osname=$OSNAME_LOWERCASE
    fmt_info "remove $1 in $osname"
    local query_result="$(python3 ${NIXDBS_HOME}/bin/jq.py --os=$osname --pkg=$1)"
    if [[ "$query_result" = "none" ]]; then
        fmt_warning "package meta not exist, now try use system package manager"
        # try to install pkg by system package manager
        pkg_remove "$1"
    else
        fmt_info "find package meta: $query_result"
        # get the packages
        local pkg_name=$(echo $query_result | awk '{$NF=""}1' | sed 's/[[:blank:]]*$//')
        local pkg_update_method=$(echo $query_result | awk '{print $NF}')
        fmt_info "update $pkg_name by $pkg_update_method"
        if [ "$pkg_update_method" = "system" ]; then
            local pkg_arr_arg=($pkg_name)
            pkg_remove "${pkg_arr_arg[@]}"
        elif [[ "$pkg_update_method" = "brew" ]]; then
            local pkg_arr_arg=($pkg_name)
            brew_remove "${pkg_arr_arg[@]}"
        elif [[ "$pkg_update_method" = "manual_compile" ]]; then
            echo "update by manual not implement yet!"
            error_exit "can not update $pkg_name manually"
        else
            error_exit "update method: ${pkg_update_method} not supported!"
        fi
    fi
}

get_pkg_install_cmd_text() {
    if [ -v $SYS_INSTALL_PKG_CMD ]; then
        error_exit "$OSNAME_LOWERCASE system install command not set correctlly!"
    fi

    declare -a install_cmd=()

    for sys_install_cmd_arg in "${SYS_INSTALL_PKG_CMD[@]}"; do
        install_cmd+=("$sys_install_cmd_arg")
    done

    for install_arg in "$@"; do
        install_cmd+=("$install_arg")
    done
    echo "${install_cmd[@]}"
}

pkg_install() {
    if [ -v $SYS_INSTALL_PKG_CMD ]; then
        error_exit "$OSNAME_LOWERCASE system install command not set correctlly!"
    fi

    declare -a install_cmd=()

    for sys_install_cmd_arg in "${SYS_INSTALL_PKG_CMD[@]}"; do
        install_cmd+=("$sys_install_cmd_arg")
    done

    for install_arg in "$@"; do
        install_cmd+=("$install_arg")
    done
    exe_sudo "${install_cmd[@]}"
}

pkg_update() {
    if [ -v $SYS_UPGRADE_PKG_CMD ]; then
        error_exit "$OSNAME_LOWERCASE system update package command not set correctlly!"
    fi

    declare -a update_cmd=()

    for sys_update_cmd_arg in "${SYS_UPGRADE_PKG_CMD[@]}"; do
        update_cmd+=("$sys_update_cmd_arg")
    done

    for update_arg in "$@"; do
        update_cmd+=("$update_arg")
    done
    exe_sudo "${update_cmd[@]}"
}

pkg_remove() {
    if [ -v $SYS_REMOVE_PKG_CMD ]; then
        error_exit "$OSNAME_LOWERCASE system remove command not set correctlly!"
    fi

    declare -a remove_cmd=()

    for sys_remove_cmd_arg in "${SYS_REMOVE_PKG_CMD[@]}"; do
        remove_cmd+=("$sys_remove_cmd_arg")
    done

    for remove_arg in "$@"; do
        remove_cmd+=("$remove_arg")
    done
    exe_sudo "${remove_cmd[@]}"
}

get_brew_install_info() {
    if ! command_exists "brew"; then
        # homebrew has already installed, but not run brew's settings
        if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
            echo "homebrew already installed, loading..."
            eval "$HOMEBREW_SETTINGS"
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        else
            error_exit "you must install Homebrew first!"
        fi
    fi
    local -a install_cmd=(brew install)

    for install_arg in "$@"; do
        install_cmd+=("$install_arg")
    done
    echo "${install_cmd[@]}"
}

brew_install() {
    if ! command_exists "brew"; then
        # homebrew has already installed, but not run brew's settings
        if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
            echo "homebrew already installed, loading..."
            eval "$HOMEBREW_SETTINGS"
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        else
            error_exit "you must install Homebrew first!"
        fi
    fi
    local -a install_cmd=(brew install)

    for install_arg in "$@"; do
        install_cmd+=("$install_arg")
    done
    execute "${install_cmd[@]}"
}

brew_upgrade() {
    if ! command_exists "brew"; then
        # homebrew has already installed, but not run brew's settings
        if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
            echo "homebrew already installed, loading..."
            eval "$HOMEBREW_SETTINGS"
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        else
            error_exit "you must install Homebrew first!"
        fi
    fi
    local -a update_cmd=(brew upgrade)

    for update_arg in "$@"; do
        update_cmd+=("$update_arg")
    done
    execute "${update_cmd[@]}"
}

brew_remove() {
    if ! command_exists "brew"; then
        # homebrew has already installed, but not run brew's settings
        if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
            echo "homebrew already installed, loading..."
            eval "$HOMEBREW_SETTINGS"
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        else
            error_exit "you must install Homebrew first!"
        fi
    fi
    local -a remove_cmd=(brew uninstall)

    for remove_arg in "$@"; do
        remove_cmd+=("$remove_arg")
    done
    execute "${remove_cmd[@]}"
}

echo_commands() {
    fmt_info "package install cmd: ${SYS_INSTALL_PKG_CMD[@]}"
    fmt_info "package upgrade cmd: ${SYS_UPGRADE_PKG_CMD[@]}"
    fmt_info "package remote cmd: ${SYS_REMOVE_CMD[@]}"
    fmt_info "system sync cmd: ${SYS_SYNC_CMD[@]}"
    fmt_info "system update cmd: ${SYS_UPGRADE_CMD[@]}"
    fmt_info "system clean cmd: ${SYS_CLEAN_CMD[@]}"
}

# =================================
# Gentoo
# =================================

gentoo_setup_portage_license() {
    fmt_info "Update portage accept license"
    if grep -q "ACCEPT_LICENSE" /etc/portage/make.conf; then
        replace_cmd=("sed" "-i" "/^ACCEPT_LICENSE/s/=.*$/=\"*\"/" "/etc/portage/make.conf")
        exe_sudo "${replace_cmd[@]}"
    else
        replace_cmd=("sed" "-i" '$aACCEPT_LICENSE=\"*\"' "/etc/portage/make.conf")
        exe_sudo "${replace_cmd[@]}"
    fi
}

setup_gentoo() {
    # package management commands
    SYS_INSTALL_PKG_CMD=("emerge" "-vn")
    SYS_UPGRADE_PKG_CMD=("emerge" "--update" "--deep" "--changed-use")
    SYS_REMOVE_PKG_CMD=("emerge" "--unmerge")
    # system commands
    SYS_SYNC_CMD=("emerge" "--sync")
    SYS_UPGRADE_CMD=("emerge" "-avuND" "@world")
    SYS_CLEAN_CMD=("emerge" "-a" "--depclean")
    gentoo_setup_portage_license

    # fmt_info "Now, test system package manager command!"
    # pkg_install "app-admin/eselect"
    # system_update
}

# =================================
# Manjaro
# =================================

setup_manjaro() {
    SYS_INSTALL_PKG_CMD=("pacman" "-Sy --needed")
    SYS_UPGRADE_PKG_CMD=("pacman" "-Syu --needed")
    SYS_UPDATE_CMD=("pacman" "-Syy")
    SYS_UPGRADE_CMD=("pacman" "-Syu")
}

# =================================
# Archlinux
# =================================

setup_arch() {
    SYS_INSTALL_PKG_CMD=("pacman" "-Sy")
    SYS_UPGRADE_PKG_CMD=("pacman" "-Sy")
    SYS_UPDATE_CMD=("pacman" "-Syy")
    SYS_UPGRADE_CMD=("pacman" "-Syu")
}

# =================================
# Ubuntu
# =================================

setup_ubuntu() {
    fmt_info "Define your system commands"
    SYS_INSTALL_PKG_CMD=("apt" "-y" "--no-install-recommends" "install")
    SYS_UPGRADE_PKG_CMD=("apt" "update")
    SYS_UPDATE_CMD=("apt" "update")
    SYS_UPGRADE_CMD=("apt" "upgrade" "-y")

}

# =================================

setup_os_commands() {
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
