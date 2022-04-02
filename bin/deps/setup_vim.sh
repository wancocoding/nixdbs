#!/usr/bin/env bash

link_vimrc()
{
	fmt_info "link vimrc ......"
	rm -rf $HOME/.vimrc >/dev/null 2>&1
	ln -s $NIXDBS_HOME/dotfiles/.vimrc $HOME/.vimrc
}

install_vim_plug()
{
	fmt_info "setup vim plugin"
	fmt_info "check vim-plug"
	if [ ! -f $HOME/.vim/autoload/plug.vim ];then
		fmt_info "install vim-plug"
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			$VIM_PLUG_VIMFILE_URL_PROXY
	fi
	fmt_info "install plugin"
	vim +PluginInstall +qall
}

setup_vim()
{
	echo_title "Setup Vim"
	if ! command_exists vim; then
		# install vim
		fmt_info "install vim"
		if [ $OSNAME_LOWERCASE = "gentoo" ]; then
			fmt_info "you are using Gentoo linux, change use flag now"
			if grep -q vim /etc/portage/package.use/dev-mask >/dev/null 2>&1;
			then 
				:;
			else
				exe_sudo_string "echo '>=app-editors/vim-8.2.4328-r1 terminal' >> /etc/portage/package.use/dev-mask"
			fi
		fi
		pkg_install "vim"
	fi
	link_vimrc
	install_vim_plug
	fmt_success "Setup vim finish!"
}

setup_vim
