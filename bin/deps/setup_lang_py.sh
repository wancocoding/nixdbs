#!/usr/bin/env bash

pyenv_rcfile_title="# ======== pyenv ========"

# see: https://github.com/pyenv/pyenv#installation
install_pyenv()
{
	fmt_info "checking pyenv..."
	if [ -d $HOME/.pyenv ];then
		echo "Pyenv exist! skip..."
	else
		fmt_info "install pyenv"

		rm -rf $HOME/.pyenv >/dev/null 2>&1

		git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
	fi
	if [ ! -d $HOME/.pyenv/plugins/pyenv-virtualenv ]; then
	    git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv	
	else
		echo "pyenv-virtualenv already installed, skip..."
	fi
}

link_pip_conf()
{
	fmt_info "link dotfile pip conf"
	rm -rf $HOME/.pip/pip.conf >/dev/null 2>&1
	# ln -s $NIXDBS_HOME/dotfiles/pip $HOME/.pip
	# echo "[global]" > $HOME/.pip/pip.conf
	# echo "url = https://pypi.tuna.tsinghua.edu.cn/simple" >> $HOME/.pip/pip.conf
	if is_set_true_in_settings "pip_use_mirror"; then
		local mirror_file="$(get_mirror_file pkg pip)"
		mkdir -p $HOME/.pip >/dev/null 2>&1
		cat "$mirror_file" > $HOME/.pip/pip.conf
	fi
}

setup_pyenv_rcfile()
{
	if ! grep -q "$pyenv_rcfile_title" $HOME/.bashrc || ! grep -q "$pyenv_rcfile_title" $HOME/.zshrc; then
		append_rc "$pyenv_rcfile_title"
		append_rc 'export PYENV_ROOT="$HOME/.pyenv"'
		append_rc 'export PATH="$PYENV_ROOT/bin:$PATH"'
		append_rc 'eval "$(pyenv init --path)"'
		append_rc 'eval "$(pyenv init -)"'
		append_rc 'eval "$(pyenv virtualenv-init -)"'
	fi
    # # for zsh
    # if [ -a $HOME/.zshrc ]; then
    #     if ! grep -Fxq 'eval "$(pyenv init -)"' $HOME/.zshrc ; then
    #         echo '' >> $HOME/.zshrc
    #
    #         echo '# ====== pyenv ====== ' >> $HOME/.zprofile
	#         echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
	#         echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
	#         echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
	#         echo 'eval "$(pyenv init -)"' >> ~/.zshrc
	#         echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
    #     fi
    # fi
    # # for bash
    # if [ -a $HOME/.bashrc ]; then
    #     if ! grep -Fxq 'export PYENV_ROOT="$HOME/.pyenv"' $HOME/.bashrc ; then
    #         echo '# ====== pyenv ====== ' >> $HOME/.bashrc
	#         echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
	#         echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
	#         echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
	#         echo 'eval "$(pyenv init -)"' >> ~/.bashrc
	#         echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
    #     fi
    # fi
	fmt_info "enable pyenv environments"
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
}

# see: https://github.com/pyenv/pyenv/wiki#suggested-build-environment
exec_install_pydeps()
{
	fmt_info "checking python dependencies"
	pkg_install_wrapper "group-py-deps"
}

install_default_python3()
{
	echo "install defalut python3"

	# list versions
	if ! pyenv versions | grep -q "$PYENV_DEFAULT_PY_VERSION" ; then
		pyenv install $PYENV_DEFAULT_PY_VERSION
	fi
	pyenv versions

}

exec_install_python()
{
	echo_title "Setup Python and pyenv"

	install_pyenv
	setup_pyenv_rcfile

	# run dependent tasks
	dependent_tasks "pydeps"

	install_default_python3
	link_pip_conf

	fmt_success "Setup Python and pyenv finish!"
}


append_task_to_init "pydeps"
append_task_to_init "python"
