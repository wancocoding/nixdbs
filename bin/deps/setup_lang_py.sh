#!/usr/bin/env bash

# see: https://github.com/pyenv/pyenv#installation
install_pyenv()
{
	fmt_info "checking pyenv..."
	if [ -d $HOME/.pyenv ];then
		echo "Pyenv exist!"
	else
		fmt_info "install pyenv"

		rm -rf $HOME/.pyenv >/dev/null 2>&1

		git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
		
		setup_pyenv_profile
	fi
}

link_pip_conf()
{
	fmt_info "link dotfile pip conf"
	rm -rf $HOME/.pip >/dev/null 2>&1
	ln -s $NIXDBS_HOME/dotfiles/pip $HOME/.pip
}

setup_pyenv_profile()
{
    # for zsh
    if [ -a $HOME/.zshrc ]; then
        if ! grep -Fxq 'eval "$(pyenv init -)"' $HOME/.zshrc ; then
            echo '' >> $HOME/.zshrc

            echo '# ====== pyenv ====== ' >> $HOME/.zprofile
			echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
			echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
			echo 'eval "$(pyenv init --path)"' >> ~/.zprofile

            echo '# ====== pyenv ====== ' >> $HOME/.zshrc
			echo 'eval "$(pyenv init -)"' >> ~/.zshrc
        fi
    fi
    # for bash
    if [ -a $HOME/.bashrc ]; then
        if ! grep -Fxq 'export PYENV_ROOT="$HOME/.pyenv"' $HOME/.bashrc ; then
            echo '# ====== pyenv ====== ' >> $HOME/.bashrc
			echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
			echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
			echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
			echo 'eval "$(pyenv init -)"' >> ~/.bashrc
        fi
		source $HOME/.bashrc
    fi
}

# see: https://github.com/pyenv/pyenv/wiki#suggested-build-environment
install_python_build_dependencies()
{
	fmt_info "checking python dependencies"
	pkg_install_wrapper "group-py-deps"
}

install_default_python3()
{
	echo "install defalut python3"
	# load rcfile
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"

	# list versions
	pyenv versions
	pyenv install $PYENV_DEFAULT_PY_VERSION
	pyenv versions

}

setup_py_kits()
{
	echo_title "Setup Python and pyenv"

	install_pyenv
	install_python_build_dependencies
	install_default_python3
	link_pip_conf

	fmt_success "Setup Python and pyenv finish!"
}


append_step "setup_py_kits"
