#!/bin/bash

# record installation information
# parameters
# 1 - task : record task name
# 2 - type : record type(ins|dir|file|rc|user|mod)
# 3 - text : record
#
# ins file format
# name,install method,install command
record_task() {
	local record_task_name="$1"
	local record_task_type="$2"
	local record_text="$3"
	# record task dir path
	local rtd_path="$HOME/.cache/nixdbs/db/${record_task_name}"

	if [ ! -d "$rtd_path" ]; then
		mkdir -p "$rtd_path"
	fi

	local record_task_file="${rtd_path}/${record_task_type}"

	record_task_info_to_file "$record_task_file" "$record_text"
}

# record task
record_task_info_to_file() {
	local record_file="$1"
	local record_text="$2"
	if [ ! -f $record_file ]; then
		touch "$record_file"
	fi
	if ! grep -Fqx "$record_text" "$record_file"; then
		echo "$record_text" >>"$record_file"
	fi
}
