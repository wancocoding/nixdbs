#!/bin/bash

# ==================================
# utility functions
# ==================================


command_exists() {
  command -v "$@" >/dev/null 2>&1
}

# check not call from subshell
if [ -t 1 ]; then
  is_tty() {
    true
  }
else
  is_tty() {
    false
  }
fi




get_setting_value()
{
	# local print_string='{print $NF}'
	# local pattern_string="/^$1/${print_string}"
	local config_file="$JOB_CONFIG_FILE"
	if [ ! -z "${CONFIG_FILE:-}" ]; then
		config_file=$CONFIG_FILE
	fi
	# local config_value=`awk '/^$1/$print_string' $config_file`
	# local config_value=`awk -v cfkey="$1" '$0 ~ cfkey {print $NF}' $config_file`
	local config_value="$(get_cfg_from_file_by_key $1 $config_file)"
	# echo "the config value of [$1] is $config_value"
	if [ ! -z "$config_value" ]; then
		echo "$config_value"
	else
		echo
	fi
}

# Deprecate , use 
# get_config_str_from_file()
# {
#     # local print_string='{print $NF}'
#     # local pattern_string="/^$1/${print_string}"
#     local config_file="$2"
#     if [ ! -z "${CONFIG_FILE:-}" ]; then
#         config_file=$CONFIG_FILE
#     fi
#     # local config_value=`awk '/^$1/$print_string' $config_file`
#     local config_value=`awk -v cfkey="$1" '$0 ~ cfkey {print $NF}' $config_file`
#     # echo "the config value of [$1] is $config_value"
#     if [ ! -z "$config_value" ]; then
#         echo "$config_value"
#     else
#         echo
#     fi
# }

# get value from a file , eg: mirror = http://mirrors.example.com
get_cfg_from_file_by_key()
{
	sed -n \
		"/^${1}\s\+\=\s\+/s/^${1}\s\+=\s\+//p" \
		$2
}


is_set_true_in_settings()
{
	# local print_string='{print $NF}'
	# local pattern_string="/^$1/${print_string}"
	local config_file="$JOB_CONFIG_FILE"
	# if [ ! -z "${CONFIG_FILE:-}" ]; then
	#     config_file=$CONFIG_FILE
	# fi
	# local config_value=`awk '/^$1/$print_string' $config_file`
	# local config_value=`awk -v cfkey="$1" '$0 ~ cfkey {print $NF}' $config_file`
	local config_value="$(get_cfg_from_file_by_key $1 $config_file)"
	echo "the config value of [$1] is $config_value"
	case $config_value in
		y*|Y*)
			return 0
			;;
		*)
			return 1
			;;
	esac
	# set as no, if not found in config file
	return 1
}

get_http_proxy()
{
	if [ ! -z "${NIXDBS_HTTP_PROXY:-}" ]; then
		echo "$NIXDBS_HTTP_PROXY"
	else
		get_setting_value "http_proxy"
	fi
}

use_http_proxy()
{
	local script_http_proxy=$(get_http_proxy)
	if [ ! -z "${script_http_proxy:-}" ]; then
		export http_proxy="$script_http_proxy"
		if [ -f $HOME/.curlrc ];then
			mv $HOME/.curlrc $HOME/.curlrc.bak
		fi
		if [ -f $HOME/.wgetrc ]; then
			mv $HOME/.wgetrc $HOME/.wgetrc.bak
		fi
		echo "proxy=${script_http_proxy}" > $HOME/.curlrc
		echo "http_proxy = ${script_http_proxy}" > $HOME/.wgetrc
	fi
}

use_http_proxy_by_setting()
{
	if is_set_true_in_settings "$1"; then
		use_http_proxy
	fi
}

unset_http_proxy()
{
	unset http_proxy
	[ -f $HOME/.curlrc ] && rm $HOME/.curlrc
	[ -f $HOME/.curlrc.bak ] && mv $HOME/.curlrc.bak$HOME/.curlrc
	[ -f $HOME/.wgetrc ] && rm $HOME/.wgetrc
	[ -f $HOME/.wgetrc.bak ] && mv $HOME/.wgetrc.bak$HOME/.wgetrc
}

append_rc()
{
	if [ -f $HOME/.zshrc ]; then
		if ! grep -q "$1" $HOME/.zshrc ;then
			echo "$1" >> $HOME/.zshrc
		fi
	fi

	if [ -f $HOME/.bashrc ]; then
		if ! grep -q "$1" $HOME/.bashrc ;then
			echo "$1" >> $HOME/.bashrc
		fi
	fi
}

append_bashrc()
{
	if ! grep -q "$1" $HOME/.bashrc ;then
		echo "$1" >> $HOME/.bashrc
	fi
}

append_zshrc()
{
	if ! grep -q "$1" $HOME/.zshrc ;then
		echo "$1" >> $HOME/.zshrc
	fi
}

append_rc_by_file()
{
	if [ -f $HOME/.zshrc ]; then
		cat "$1" >> $HOME/.zshrc
	fi

	if [ -f $HOME/.bashrc ]; then
		cat "$1" >> $HOME/.bashrc
	fi
}

append_bashrc_by_file()
{
	if [ -f $HOME/.bashrc ]; then
		cat "$1" >> $HOME/.bashrc
	fi
}

append_zshrc_by_file()
{
	if [ -f $HOME/.zshrc ]; then
		cat "$1" >> $HOME/.zshrc
	fi
}


curl_wrapper()
{
	local http_proxy=$(get_http_proxy)
	if [ ! -z "${http_proxy:-}" ]; then
		curl -x $http_proxy --connect-timeout 10 --retry-delay 2 --retry 3	"$@"
	else
		curl --connect-timeout 10 --retry-delay 2 --retry 3	"$@"
	fi
}


# param 1: [os|pkg]
# param 2: [pkgname] example: homebrew
get_mirror_file()
{
	if [ ! -z ${1:-} ] && [ ! -z ${2:-} ]; then
		local mirror_area="$(get_setting_value mirror_area)"
		local mirror_type="$1"
		local mirror_name="$2"
		local mirror_file="$NIXDBS_HOME/misc/mirrors/${mirror_area}/${mirror_type}/${mirror_name}"
		echo "$mirror_file"
	else
		error_exit "mirror settings not found! check settings and configs."
	fi
}


append_step()
{
	SETUP_STEPS_ARRAY+=("$1")
}

run_step()
{
	# local encode_title=`echo "$1" | base64`
	local encode_title="$1"
	if is_set_true_in_settings "$1"; then
		if grep -Fxq "$encode_title" "$NIXDBS_CACHE_STEP_FILE"; then
			# step already executed, skip this step
			echo "Skip $1, it has already finished"
			return
		else
			"$1"
			echo "$encode_title" >> "$NIXDBS_CACHE_STEP_FILE"
		fi
	else
		# skip this step by config
		echo "Skip $1, according to configuration file"
		return
	fi
}

run_all_steps()
{
	local step_total="${#SETUP_STEPS_ARRAY[@]}"
	let step_index=1
	for si in "${!SETUP_STEPS_ARRAY[@]}"; do
		echo
		fmt_info ">>> run setup step (${step_index} of ${step_total})"
		run_step "${SETUP_STEPS_ARRAY[si]}"
		let step_index+=1
	done
}

run_sub_step()
{
	local encode_title="$1"
	if grep -Fxq "SUB-${encode_title}" "$NIXDBS_CACHE_STEP_FILE"; then
		# step already executed, skip this step
		echo "Skip $1, it has already finished"
		return
	else
		"$1"
		echo "SUB-${encode_title}" >> "$NIXDBS_CACHE_STEP_FILE"
	fi
}

run_specified_steps()
{
	local step_total="${#specified_steps[@]}"
	let step_index=1
	for si in "${!specified_steps[@]}"; do
		echo
		fmt_info ">>> run step (${step_index} of ${step_total})"
		local step_name_i="${specified_steps[si]}"
		case $step_name_i in
			osmir)
				setup_os_mirror
				;;
			sys)
				init_system
				;;
			base)
				setup_basic_dev_kits
				;;
			brew)
				setup_homebrew
				;;
			git)
				setup_git
				;;
			tools)
				install_tools
				;;
			tldr)
				install_tldr
				;;
			cheatsh)
				install_cheatsh
				;;
			zsh)
				setup_zsh
				;;
			ohmyzsh)
				install_ohmyzsh
				;;
			vim)
				setup_vim
				;;
			clang)
				setup_c_kits
				;;
			ruby)
				setup_rb_kits
				;;
			node)
				setup_node_kits
				;;
			java)
				setup_java_kits
				;;
			go)
				setup_go_kits
				;;
			python)
				setup_py_kits
				;;
			python-deps)
				install_python_build_dependencies			
				;;
			*)
				error_exit "the setup step [$step_name_i] does not exist."
				;;
		esac

		let step_index+=1
	done
}

main_step()
{
	if [ $JOB_NAME = "init" ];then
		run_all_steps
	elif [ $JOB_NAME = "install" ]; then
		run_specified_steps
	elif [ $JOB_NAME = "update" ]; then
		echo "run update job"
	elif [ $JOB_NAME = "remove" ]; then
		echo "run remove job"
	fi
	# if [ ${#specified_steps[@]} -gt 0 ]; then
	#     run_specified_steps
	# else
	#     run_all_steps
	# fi
}
