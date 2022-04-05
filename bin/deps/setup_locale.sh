#!/usr/bin/env bash


# ==================================
# Setup locale
# ==================================

setup_locale()
{
	  echo_title "Setup locale"
		exe_sudo_string "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
		exe_sudo_string "echo 'en_US ISO-8859-1' >> /etc/locale.gen"
		exe_sudo_string "echo 'zh_CN.UTF-8 UTF-8' >> /etc/locale.gen"
		exe_sudo_string "echo 'zh_CN.GB18030 GB18030' >> /etc/locale.gen"
		exe_sudo_string "echo 'zh_CN.GBK GBK' >> /etc/locale.gen"
		exe_sudo_string "echo 'zh_CN GB2312' >> /etc/locale.gen"
		exe_sudo_string "echo 'zh_TW.UTF-8 UTF-8' >> /etc/locale.gen"
		exe_sudo_string "echo 'zh_TW BIG5' >> /etc/locale.gen"
		if command_exists locale-gen; then
				exe_sudo_string "locale-gen"
		else
			  fmt_error "Can not generate locale by locale-gen, command not exists!"
				error_exit "make sure locale-gen is on your system"
		fi
		if command_exists localectl; then
        exe_sudo_string "localectl set-locale LANG=en_US.UTF-8"
		else
			  exe_sudo_string "echo 'LANG=en_US.UTF-8' > /etc/locale.conf"
		fi
		locale
		localectl
		fmt_success "Setup locale"
}


append_step "setup_locale"
