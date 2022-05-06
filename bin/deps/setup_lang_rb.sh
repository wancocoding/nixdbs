#!/usr/bin/env bash

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

link_gemrc()
{
	fmt_info "link gemrc file"
	rm -rf $HOME/.gemrc >/dev/null 2>&1
	echo "$GEMRC_SETTINGS" > $HOME/.gemrc
	# ln -s $NIXDBS_HOME/dotfiles/gemrc $HOME/.gemrc

}

setup_rbenv_profile()
{
	append_rc '# ====== rbenv ====== '
	append_rc 'export PATH="$HOME/.rbenv/bin:$PATH"'
	append_rc 'eval "$(rbenv init -)"'
    # for zsh
    # if [ -a $HOME/.zshrc ]; then
    #     if ! grep -Fxq 'export PATH="$HOME/.rbenv/bin:$PATH"' $HOME/.zshrc ; then
    #         echo '' >> $HOME/.zshrc
    #
    #         echo '# ====== rbenv ====== ' >> $HOME/.zshrc
	#         echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
	#         # echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
    #     fi
    # fi
    # # for bash
    # if [ -a $HOME/.bashrc ]; then
    #     if ! grep -Fxq 'export PATH="$HOME/.rbenv/bin:$PATH"' $HOME/.bashrc ; then
    #         echo '# ====== rbenv ====== ' >> $HOME/.bashrc
	#         echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
	#         echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    #     fi
    # fi
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

setup_rb_kits()
{
	echo_title "Setup Ruby and rbenv"

	install_rbenv

	setup_rbenv_profile

	install_default_ruby

	link_gemrc

	fmt_success "Setup Ruby and rbenv finish!"
}


append_step "setup_rb_kits"

