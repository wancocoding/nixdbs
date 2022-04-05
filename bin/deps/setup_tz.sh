#!/usr/bin/env bash


# ==================================
# Setup timezone
# ==================================

set_tz_systemd()
{
	  if command_exists "timedatectl"; then
				exe_sudo "timedatectl set-timezone Asia/Shanghai"
				exe_sudo "timedatectl"
				return 0
		fi
}


setup_timezone()
{
		echo_title "Setup Timezone"
		# if command_exists "tzselect"; then
		#	    exe_sudo tzselect
		if command_exists timedatectl; then
			  exe_sudo_string "timedatectl set-timezone Asia/Shanghai"
				exe_sudo_string "timedatectl"
		elif [ -a /usr/share/zoneinfo/Asia/Shanghai  ]; then
			  exe_sudo_string "ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime"
				exe_sudo_string "echo ${TIMEZONE} > /etc/timezone"
		else
			  fmt_warning "you should set your time zone manually later!"
				return 1
		fi
		fmt_success "Setup timezone"

}


run_step "setup_timezone"

