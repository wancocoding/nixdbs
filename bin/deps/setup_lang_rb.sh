#!/usr/bin/env bash

rbenv_rcfile_title="# ======== rbenv settings ========"

install_rbenv()
{
	fmt_info "checking rbenv..."
	if [ -d $HOME/.rbenv ];then
		echo "rbenv exist!"
	else
		fmt_info "install rbenv"

		rm -rf $HOME/.rbenv >/dev/null 2>&1

		git clone https://github.com/rbenv/rbenv.git ~/.rbenv
		
		
	fi
}

setup_gemrc()
{
	fmt_info "link gemrc file"
	rm -rf $HOME/.gemrc >/dev/null 2>&1
	# echo "$GEMRC_SETTINGS" > $HOME/.gemrc
	if is_set_true_in_settings "rubygem_use_mirror"; then
		local mirror_file="$(get_mirror_file pkg gem)"
		cat "$mirror_file" > $HOME/.gemrc
	fi
	# ln -s $NIXDBS_HOME/dotfiles/gemrc $HOME/.gemrc

}

setup_rbenv_profile()
{
	if ! grep -q "$rbenv_rcfile_title" $HOME/.bashrc || ! grep -q "$rbenv_rcfile_title" $HOME/.zshrc; then
		append_rc "$rbenv_rcfile_title"
		append_rc 'export PATH="$HOME/.rbenv/bin:$PATH"'
		append_rc 'eval "$(rbenv init -)"'
	fi

	# enable rbenv now
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"

	# install ruby-build
	fmt_info "install ruby-build plugin"
	mkdir -p "$(rbenv root)"/plugins >/dev/null 2>&1
	if [ ! -d "$(rbenv root)"/plugins/ruby-build ]; then
		git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
	fi

}


install_default_ruby()
{
	echo "install defalut Ruby version"
	export PATH="$HOME/.rbenv/bin:$PATH"

	# list versions
	rbenv install --list
	if ! rbenv versions | grep -q "$RBENV_DEFALUT_RUBY_VERSION" ; then
		rbenv install "$RBENV_DEFALUT_RUBY_VERSION"
		rbenv versions
	else
		fmt_info "ruby default version ${RBENV_DEFALUT_RUBY_VERSION} already installed"
	fi
	# checking install
	fmt_info "checking rbenv install by rbenv-doctir"
	curl_wrapper -fsSL "https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor" | bash
	# local http_proxy=$(get_http_proxy)
	# if [ ! -z "${http_proxy:-}" ]; then
	#     curl --proxy $http_proxy -fsSL "https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor" | bash
	# else
	#     curl -fsSL "https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor" | bash
	# fi
}

exec_install_ruby()
{
	echo_title "Setup Ruby and rbenv"
	use_http_proxy_by_setting "install_ruby_use_proxy"

	install_rbenv

	setup_rbenv_profile

	install_default_ruby

	setup_gemrc

	unset_http_proxy

	fmt_success "Setup Ruby and rbenv finish!"
}


append_task_to_init "ruby"

