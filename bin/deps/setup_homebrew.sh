#!/usr/bin/env bash

# ==================================
# Setup Homebrew
# ==================================

homebrew_rcfile_title="# ======== Homebrew ========"


exec_install_brew()
{
	echo_title "Setup Homebrew"
	use_http_proxy_by_setting "install_homebrew_use_proxy"
    if command_exists brew || [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
        echo "You have installed Homebrew already! Skip this step."
    else
		if is_set_true_in_settings "homebrew_use_mirror"; then
			local mirror_file="$(get_mirror_file pkg homebrew)"
			eval "$(<$mirror_file)"
		fi
		curl_wrapper -fsSL https://github.com/Homebrew/install/raw/HEAD/install.sh | bash
		# local http_proxy=$(get_http_proxy)
		# if [ ! -z "${http_proxy:-}" ]; then
		#     echo "install brew by http proxy"
		#     /bin/bash -c "$(curl --proxy $http_proxy -fsSL https://github.com/Homebrew/install/raw/HEAD/install.sh)"
		# else
		#     /bin/bash -c "$(curl -fsSL https://github.com/Homebrew/install/raw/HEAD/install.sh)"
		# fi
    fi
    setup_rcfile_for_homebrew
	unset_http_proxy

	record_task "homebrew" "dir" "/home/linuxbrew"
	fmt_success "finish setup homebrew."
}

setup_rcfile_for_homebrew()
{
	fmt_info "setup rcfile for homebrew"
	if ! grep -q "$homebrew_rcfile_title" $HOME/.bashrc;then
		append_bashrc "$homebrew_rcfile_title"
		append_bashrc 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
		append_bashrc "export HOMEBREW_NO_AUTO_UPDATE=1"
		record_task "homebrew" "rc" "$homebrew_rcfile_title"
		record_task "homebrew" "rc"  'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
		record_task "homebrew" "rc"  "export HOMEBREW_NO_AUTO_UPDATE=1"
		# get the mirror file
		if is_set_true_in_settings "homebrew_use_mirror"; then
			local mirror_file="$(get_mirror_file pkg homebrew)"
			append_bashrc_by_file $mirror_file
			record_task "homebrew" "rc" "$(cat $mirror_file)"
		fi
	fi
	if ! grep -q "$homebrew_rcfile_title" $HOME/.zshrc;then
		append_zshrc "$homebrew_rcfile_title"
		append_zshrc 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
		append_zshrc "export HOMEBREW_NO_AUTO_UPDATE=1"
		record_task "homebrew" "rc" "$homebrew_rcfile_title"
		record_task "homebrew" "rc"  'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
		record_task "homebrew" "rc"  "export HOMEBREW_NO_AUTO_UPDATE=1"
		# get the mirror file
		if is_set_true_in_settings "homebrew_use_mirror"; then
			local mirror_file="$(get_mirror_file pkg homebrew)"
			append_zshrc_by_file $mirror_file
			record_task "homebrew" "rc" "$(cat $mirror_file)"
		fi
	fi
	# eval "$HOMEBREW_SETTINGS"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	fmt_info "checking installed homebrew"
	brew -v
}


append_task_to_init "brew"


exec_update_brew()
{
	echo_title "update homebrew"
    if command_exists brew || [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
		brew update
		fmt_success "finish update homebrew."
	else
		error_exit "You must install Homebrew first!"
	fi

}
