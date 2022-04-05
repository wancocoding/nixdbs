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


get_config()
{
	local print_string='{print $NF}'
	local pattern_string="/^$1/${print_string}"
	local config_file="../nixdbs.default.conf"
	if [ ! -z "${CONFIG_FILE:-}" ]; then
		config_file=$CONFIG_FILE
	fi
	# local config_value=`awk '/^$1/$print_string' $config_file`
	local config_value=`awk -v cfkey="$1" '$0 ~ cfkey {print $NF}' $config_file`
	echo "the config value of [$1] is $config_value"
	case $config_value in
		y*)
			return 0
			;;
		*)
			return 1
			;;
	esac
	# set as no, if not found in config file
	return 1
}

append_step()
{
	SETUP_STEPS_ARRAY+=("$1")
}

run_step()
{
	local encode_title=`echo "$1" | base64`
	if get_config "$1"; then
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

main_step()
{
	local step_total="${#SETUP_STEPS_ARRAY[@]}"
	let step_index=1
	for si in "${!SETUP_STEPS_ARRAY[@]}"; do
		echo ">>> run setup step (${step_index} of ${step_total})"
		run_step "${SETUP_STEPS_ARRAY[si]}"
		let step_index+=1
	done
}
