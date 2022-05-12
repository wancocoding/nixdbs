#!/usr/bin/env bash

nvm_rcfile_title="# ======== Node and NVM ========"
# setup node and nvm

install_nvm()
{
	fmt_info "install nvm" 
	if [ ! -d $HOME/.nvm  ]; then
		export NVM_DIR="$HOME/.nvm" && (
			git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
			cd "$NVM_DIR"
			git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
		) && \. "$NVM_DIR/nvm.sh"
	fi
	fmt_info "[ok] nvm already installed"

}

link_npmrc()
{
	fmt_info "add dotfile npmrc"
	rm -rf $HOME/.npmrc >/dev/null 2>&1
	if is_set_true_in_settings "npm_use_mirror"; then
		local mirror_file="$(get_mirror_file pkg npm)"
		cat "$mirror_file" > $HOME/.npmrc
	fi
	# ln -s $NIXDBS_HOME/dotfiles/npmrc $HOME/.npmrc
}

setup_nvm_profile()
{
	if ! grep -q "$nvm_rcfile_title" $HOME/.bashrc || ! grep -q "$nvm_rcfile_title" $HOME/.zshrc; then
		append_rc "$nvm_rcfile_title"
		append_rc 'export NVM_DIR="$HOME/.nvm"'
		append_rc '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm'
		# add base completion
		append_bashrc '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'
	fi
}

install_global_node()
{
	fmt_info "setup a global node version"
	# if [ "$(ps | grep `echo $$` | awk '{ print $4 }')" = "bash" ];then
	#	echo "your shell is bash, now reload bashrc"
	#	source $HOME/.bashrc
	# fi
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	use_http_proxy_by_setting "install_node_use_proxy"

	nvm install --lts="$GLOBAL_NODE_VERSION"
	nvm alias default "lts/$GLOBAL_NODE_VERSION"
	nvm use default

	unset_http_proxy
	fmt_info "Install global node ${GLOBAL_NODE_VERSION} finish"
}

exec_install_node()
{
	echo_title "Setup Node and NVM"
	fmt_info "checking nvm..."
	# see: https://github.com/nvm-sh/nvm#manual-install
	install_nvm
	link_npmrc
	setup_nvm_profile
	install_global_node

	fmt_success "Setup Node and NVM finish!"
}


append_task_to_init "node"
