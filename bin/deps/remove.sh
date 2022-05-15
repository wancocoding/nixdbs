#!/bin/bash

remove_by_task_name()
{
	echo_title "Remove ${1}"
	# check
	local cache_setup_file="$HOME/.cache/nixdbs/setup_tasks"
	if [ -f "$cache_setup_file" ]; then
		if grep -Fxq "$1" $cache_setup_file;then
			remove_follow_record "$1"
		else
			error_exit "$1 has not setup."
		fi
	else
		error_exit "You have not run any task!"
	fi
}

remove_follow_record()
{
	local info_task_name="$1"
	if [ -d "$HOME/.cache/nixdbs/db/${1}" ];then
		remove_task_install_packages "$info_task_name"
		remove_task_dirs "$info_task_name"
		remove_task_files "$info_task_name"
		remove_task_rcfile "$info_task_name"
		remove_task_mods "$info_task_name"
		fmt_success "Remove ${1} finish!"
		rm -rf "$HOME/.cache/nixdbs/db/${1}"
	else
		error_exit "$1 has not installed or setup."
	fi
} 

remove_task_install_packages()
{
	echo 
	fmt_info "1. Remove install packages"
	local file_ins="$HOME/.cache/nixdbs/db/${1}/ins"
	remove_count=0
	if [ -f "$file_ins" ];then
		while read -r file_line; do
			local pkg_ins_info_name=`echo $file_line|awk -F, '{print $1}'`
			local pkg_ins_info_method=`echo $file_line|awk -F, '{print $2}'`
			local pkg_ins_info_cmd=`echo $file_line|awk -F, '{print $3}'`
			# echo "- name      :    ${pkg_ins_info_name}"
			# echo "- method    :    ${pkg_ins_info_method}"
			# echo "- command   :    ${pkg_ins_info_cmd}"
			echo "remove package $pkg_ins_info_name"
			if [ "$pkg_ins_info_method" = "sys" ] || [ "$pkg_ins_info_method" = "homebrew" ];then
				pkg_remove_wrapper "$pkg_ins_info_name"
				let remove_count+=1
			else
				fmt_warning "${pkg_ins_info_name} was installed by command \'${pkg_ins_info_cmd}\'"
				fmt_warning "you can uninstall it by your self."
			fi
		done < "$file_ins"
		echo "remove install package finish."
	fi
	if [ $remove_count -ge 1 ]; then
		echo "Run system clean command."
		system_clean
	fi
}

remove_task_dirs()
{
	echo
	fmt_info "2. Remove install directories"
	local file_dirs="$HOME/.cache/nixdbs/db/${1}/dir"
	if [ -f "$file_dirs" ];then
		while read -r file_line; do
			echo "remove dir - $file_line"
			rm -rf "$file_line"
		done < "$file_dirs"
	fi
}

remove_task_files()
{
	fmt_info "3. Remove Files"
	local file_files="$HOME/.cache/nixdbs/db/${1}/file"
	if [ -f "$file_files" ];then
		while read -r file_line; do
			echo "remove file - $file_line"
			if [ -f $file_line ];then
				rm "$file_line"
			fi
		done < "$file_files"
	fi
}

remove_task_rcfile()
{
	fmt_info "4. Rcfiles (Manually):"
	local file_rcfiles="$HOME/.cache/nixdbs/db/${1}/rc"
	if [ -f "$file_rcfiles" ];then
		echo "#############################################"
		cat $file_rcfiles
		echo "#############################################"
		fmt_warning "you can remove the content above in your bashrc or zshrc manually"
	fi
}

remove_task_mods()
{
	echo "5. Modify files(Manually)"
	local file_mods="$HOME/.cache/nixdbs/db/${1}/mod"
	if [ -f "$file_mods" ];then
		fmt_warning "these files has been updated, you have to restore them by yourself manually!"
		while read -r file_line; do
			echo "- $file_line"
		done < "$file_mods"
	fi
}
