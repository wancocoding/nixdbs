#!/usr/bin/env bash

link_vimrc() {
	fmt_info "link vimrc ......"
	rm -rf $HOME/.vimrc >/dev/null 2>&1
	cp -rv $NIXDBS_HOME/dotfiles/vimrc $HOME/.vimrc
	record_task "vim" "file" "$HOME/.vimrc"
	# ln -s $NIXDBS_HOME/dotfiles/vimrc $HOME/.vimrc
}

install_vim_plug() {
	fmt_info "setup vim plugin"
	fmt_info "checking vim-plug ..."
	if [ ! -f $HOME/.vim/autoload/plug.vim ]; then
		fmt_info "install vim-plug"
		curl_wrapper -fLo ~/.vim/autoload/plug.vim --create-dirs \
			$VIM_PLUG_VIMFILE_URL
		record_task "vim" "dir" "$HOME/.vim/autoload"
		record_task "vim" "file" "$HOME/.vim/autoload/plug.vim"
	fi
	fmt_info "install plugin"
	vim +PlugInstall +qall
	record_task "vim" "dir" "$HOME/.vim/plugged"
}

copy_dictionary() {
	fmt_info "setup dictionary for vim"
	if [ ! -d "/usr/share/dict" ]; then
		exe_sudo "mkdir" "-p" "/usr/share/dict"
	fi
	if [ ! -f "/usr/share/dict/words" ]; then
		exe_sudo "cp" "$NIXDBS_HOME/misc/commons/words.txt" "/usr/share/dict/words"
		record_task "vim" "file" "/usr/share/dict/words"
	fi
}

exec_install_vim() {
	echo_title "Setup Vim"
	if ! command_exists vim; then
		# install vim
		fmt_info "install vim"
		if [ $OSNAME_LOWERCASE = "gentoo" ]; then
			fmt_info "you are using Gentoo linux, change use flag now"
			if grep -q vim /etc/portage/package.use/dev-mask >/dev/null 2>&1; then
				:
			else
				exe_sudo_string "echo '>=app-editors/vim-8.2.4328-r1 python terminal' >> /etc/portage/package.use/dev-mask"
			fi
		fi
		pkg_install "vim"
		record_task "vim" "ins" "$(get_pkg_install_cmd_text vim)"
	fi
	link_vimrc
	install_vim_plug
	copy_dictionary

	fmt_success "Setup vim finish!"
}

append_task_to_init "vim"

exec_update_vim() {
	echo_title "update vim"

	if ! command -v "vim"; then
		error_exit "vim not installed yet!"
	fi

	pkg_update_wrapper vim

	fmt_success "update vim finish!"

}
