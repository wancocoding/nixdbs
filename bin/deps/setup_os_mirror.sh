#!/usr/bin/env bash


replace_gentoo_mirror()
{
    # change the package manager mirror
    fmt_info "Change portage repos mirror"
    if [ -f /etc/portage/repos.conf/gentoo.conf ]; then
        local replace_cmd=("sed" "-i" "/^sync-uri /s/=.*/= ${1}/" "/etc/portage/repos.conf/gentoo.conf")
        exe_sudo "${replace_cmd[@]}"
    fi
    # change the gentoo mirror
    fmt_info "Change portage make conf"
    local replace_cmd=("sed" "-i" "/^GENTOO_MIRRORS/s/=.*$/=\"${2}\"/" "/etc/portage/make.conf")
    exe_sudo "${replace_cmd[@]}"
}

setup_gentoo_mirror()
{
	local mirror_area="$(get_setting_value mirror_area)"
	if [ -n $mirror_area ]; then
		local mirror_settings_file="$NIXDBS_HOME/misc/mirrors/${mirror_area}/os/${OSNAME_LOWERCASE}/mirror.conf"
		local rsync_mirror="$(get_cfg_from_file_by_keyr sync $mirror_settings_file)"
		local gentoo_mirror="$(get_cfg_from_file_by_key mirror $mirror_settings_file)"
		replace_gentoo_mirror $rsync_mirror $gentoo_mirror
	else
		error_exit "You must define mirror_area in your config file if you want to change you package manager source mirror"
	fi
}

setup_manjaro_mirror()
{
    fmt_info "Change pacman repos mirror"
	if grep -q tsinghua /etc/pacman.d/mirrorlist ; then
		fmt_info "mirror already existed!"
	else
		fmt_info "mirror server not existed, now add it."
		insert_ln=$(grep -Fn Server /etc/pacman.d/mirrorlist | sed -n  '1p' | cut --delimiter=":" --fields=1)
		# exe_sudo "sed" "-i" "'${insert_ln} i\ $MANJARO_MIRROR'" "/etc/pacman.d/mirrorlist"
		exe_sudo_string "sed -i '${insert_ln}i ${MANJARO_MIRROR}' /etc/pacman.d/mirrorlist"
		unset insert_ln
	fi
}

setup_arch_mirror()
{
    fmt_info "Change pacman repos mirror"
	if grep -q tsinghua /etc/pacman.d/mirrorlist ; then
		fmt_info "mirror already existed!"
	else
		fmt_info "mirror server not existed, now add it."
		insert_ln=$(grep -Fn Server /etc/pacman.d/mirrorlist | sed -n  '1p' | cut --delimiter=":" --fields=1)
		# exe_sudo "sed" "-i" "'${insert_ln}i $ARCH_MIRROR'" "/etc/pacman.d/mirrorlist"
		exe_sudo_string "sed -i '${insert_ln}i ${ARCH_MIRROR}' /etc/pacman.d/mirrorlist"
		unset insert_ln
	fi
}

setup_ubuntu_mirror()
{
    fmt_info "Change apt repos mirror"
	exe_sudo_string "echo" "'$UBUNTU_MIRROR'" ">" "/etc/apt/sources.list"
}

setup_os_mirror()
{
    echo_title "Setup system mirror"
	if is_set_true_in_settings "os_package_manager_use_mirror"; then
		case $OSNAME_LOWERCASE in
			gentoo)
				fmt_info "Your os is Gentoo Linux!"
				setup_gentoo_mirror
				;;
			manjaro)
				fmt_info "Your os is Manjaro Linux!"
				setup_manjaro_mirror
				;;
			arch)
				fmt_info "Your os is ArchLinux!"
				setup_arch_mirror
				;;
			ubuntu)
				fmt_info "Your os is Ubuntu!"
				setup_ubuntu_mirror
				;;
			*)
				error_exit "Sorry, $OSNAME_LOWERCASE is not supported right now."
				;;
		esac
	else
		echo "Skip this step, according to your config file"
	fi
	fmt_success "Setup system mirror finish!"
}

append_step "setup_os_mirror"
