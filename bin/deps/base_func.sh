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
		n*|N*)
			return 1
			;;
		*)
			echo "Warning: The config of [${1}] is missing! Skip this task."
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
	if [ -f $HOME/.curlrc ];then
		rm $HOME/.curlrc
	fi
	if [ -f $HOME/.curlrc.bak ]; then
		mv $HOME/.curlrc.bak $HOME/.curlrc
	fi
	if [ -f $HOME/.wgetrc ];then
		rm $HOME/.wgetrc
	fi
	if [ -f $HOME/.wgetrc.bak ]; then
		mv $HOME/.wgetrc.bak $HOME/.wgetrc
	fi
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


append_task_to_init()
{
	SETUP_TASKS_ARRAY+=("$1")
}

run_job_and_tasks()
{
	if [ "$JOB_NAME" = "init" ];then
		# copy array to specified_steps
		specified_steps=( "${SETUP_TASKS_ARRAY[@]}" )
	fi
	local step_total="${#specified_steps[@]}"
	let step_index=1
	for si in "${!specified_steps[@]}"; do
		echo
		fmt_info ">>> run ${JOB_NAME} task (${step_index} of ${step_total})"
		local task_name_i="${specified_steps[si]}"
		# if [ "$JOB_NAME" = "install" ] || [ "$JOB_NAME" = "init" ];then
		#     install_task_wrapper "$task_name_i"
		# fi
		run_job_task "$JOB_NAME" "$task_name_i"
		let step_index+=1
	done
}

run_job_task()
{
	# record setup tasks
	local job_name="$1"
	local task_name_arg="$2"
	if [ "${job_name}" = "init" ];then
		if is_set_true_in_settings "$task_name_arg"; then
			if grep -Fxq "$task_name_arg" "$NIXDBS_CACHE_SETUP_TASKS_FILE"; then
				# step already executed, skip this step
				echo "Skip $task_name_arg, it has already finished"
				return
			else
				eval "exec_install_${task_name_arg}"	
				echo "$task_name_arg" >> "$NIXDBS_CACHE_SETUP_TASKS_FILE"
			fi
		else
			# skip this step by config
			echo "Skip $task_name_arg, according to configuration file"
			return
		fi
	elif [ "$job_name" = install ]; then
		if grep -Fxq "$task_name_arg" "$NIXDBS_CACHE_SETUP_TASKS_FILE"; then
			if [ $NIXDBS_RUN_MODE_FORCE == 0 ]; then
				eval "exec_install_${task_name_arg}"	
				echo "$task_name_arg" >> "$NIXDBS_CACHE_SETUP_TASKS_FILE"
			else
				# step already executed, skip this step
				echo "Skip $task_name_arg, it has already finished"
				return
			fi
		else
			eval "exec_install_${task_name_arg}"	
			echo "$task_name_arg" >> "$NIXDBS_CACHE_SETUP_TASKS_FILE"
		fi
	else
		eval "exec_${job_name}_${task_name_arg}"
	fi
}

dependent_tasks()
{
	for task_name_i in "$@"
	do
		run_job_task "install" "${task_name_i}"
	done
}


main_step()
{
	case $JOB_NAME in
		info)
			show_nixdbs_infomation
			;;
		init|install|update|remove)
			run_job_and_tasks
			;;
		*)
			echo "Error: Job not exist."
			exit 1
	esac
}
