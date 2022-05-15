#!/bin/bash

show_nixdbs_infomation()
{
	echo_title "Show Nixdbs Information"
	# show system package mamager mirror information
	# show install basic package
	# show git version
	# show vim version
	local cache_setup_file="$HOME/.cache/nixdbs/setup_tasks"
	if [ -f "$cache_setup_file" ]; then
		while read -r s_line
		do
			show_task_info "$s_line"
		done < "$cache_setup_file"
	else
		error_exit "You have not run any task!"
	fi
}

show_task_info()
{
	local info_task_name="$1"
	echo
	fmt_info "Infomation of [${info_task_name}]"

	echo
	task_info_installation "$info_task_name"
	echo
	task_info_directories "$info_task_name"
	echo
	task_info_files "$info_task_name"
	echo
	task_info_rcfiles "$info_task_name"
	echo
	task_info_mods "$info_task_name"

}

task_info_installation()
{
	echo
	echo "1. Install packages:"
	local file_ins="$HOME/.cache/nixdbs/db/${1}/ins"
	if [ -f "$file_ins" ];then
		while read -r file_line; do
			local pkg_ins_info_name=`echo $file_line|awk -F, '{print $1}'`
			local pkg_ins_info_method=`echo $file_line|awk -F, '{print $2}'`
			local pkg_ins_info_cmd=`echo $file_line|awk -F, '{print $3}'`
			echo "- name      :    ${pkg_ins_info_name}"
			echo "- method    :    ${pkg_ins_info_method}"
			echo "- command   :    ${pkg_ins_info_cmd}"
		done < "$file_ins"
	fi
}

task_info_directories()
{
	echo
	echo "2. Directories:"
	local file_dirs="$HOME/.cache/nixdbs/db/${1}/dir"
	if [ -f "$file_dirs" ];then
		while read -r file_line; do
			echo "- $file_line"
		done < "$file_dirs"
	fi
}

task_info_files()
{
	echo
	echo "3. Files:"
	local file_files="$HOME/.cache/nixdbs/db/${1}/file"
	if [ -f "$file_files" ];then
		while read -r file_line; do
			echo "- $file_line"
		done < "$file_files"
	fi
}

task_info_rcfiles()
{
	echo
	echo "4. Relative Rcfiles(updated zshrc or bashrc):"
	local file_rcfiles="$HOME/.cache/nixdbs/db/${1}/rc"
	if [ -f "$file_rcfiles" ];then
		echo "#############################################"
		cat $file_rcfiles
		echo "#############################################"
	fi
}


task_info_mods()
{
	echo
	echo "5. Modify files:"
	local file_mods="$HOME/.cache/nixdbs/db/${1}/mod"
	if [ -f "$file_mods" ];then
		while read -r file_line; do
			echo "- $file_line"
		done < "$file_mods"
	fi
}
