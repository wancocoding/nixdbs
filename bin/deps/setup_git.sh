#!/usr/bin/env bash


# ==================================
# Setup Git
# ==================================

# check git installed
setup_git()
{
	echo_title "Setup git"
	if ! command -v git 1>/dev/null 2>&1; then
		fmt_warning "Git is not installed, now install git " >&2
		pkg_install_wrapper git
	else
		fmt_info "git already installed"
	fi
    fmt_info "now setup git and config"
		if [ ! "$(git config --global user.name)" ]; then
				read -p "enter your name[coco]: > " input_text
				if [ ! -z $input_text ] && [ $input_text != " " ]; then
						git config --global user.name "$input_text"
				else
						fmt_warning "you should setup your git config [user.name] later!"
				fi
		fi
		if [ ! "$(git config --global user.email)" ]; then
				read -p "enter your email[username@gmail.com]: > " input_text
				if [ ! -z $input_text ] && [ $input_text != " " ]; then
						git config --global user.email "$input_text"
				else
						fmt_warning "you should setup your git config [user.email] later!"
				fi
		fi
    # git config --global user.name
    # git config --global user.email
    # git config --global http.proxy

	if is_set_true_in_settings "git_use_proxy";then
		local http_proxy=$(get_http_proxy)
		if [ ! -z "${http_proxy:-}" ]; then
			fmt_info "set git global config http.proxy"
			git config --global http.proxy $http_proxy
		fi
	fi
        # common git settings
	execute git config --global core.autocrlf false
	execute git config --global core.eol lf
	execute git config --global pull.rebase true
	execute git config --global core.editor vim
	execute git config --global core.filemode false
	execute git config --global merge.tool vimdiff
	execute git config --global mergetool.prompt false
	execute git config --global mergetool.keepbackup false


    # git alias settings
    # git push
    execute git config --global alias.p 'push'

    # git status
    execute git config --global alias.st 'status -sb'

    # git log
    execute git config --global alias.ll 'log --oneline'
    execute git config --global alias.lla 'log --oneline --decorate --graph --all'

    # last commit
    execute git config --global alias.last 'log -1 HEAD --stat'

    # git commit
    execute git config --global alias.cm 'commit'
    execute git config --global alias.cmm 'commit -m'

    # git checkout
    execute git config --global alias.co 'checkout'

    # git remote
    execute git config --global alias.rv 'remote -v'

    # git diff 
    execute git config --global alias.d 'diff'
    execute git config --global alias.dv 'difftool -t vimdiff -y'

    # list git global config
    execute git config --global alias.gl 'config --global -l'

    # git branch
    execute git config --global alias.br "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"

    # reset last 
    execute git config --global alias.undo 'reset HEAD~1 --mixed'

    # git template 
	cat $NIXDBS_HOME/dotfiles/config/git_commit_template > ~/.config/git_commit_template
	git config --global commit.template ~/.config/git_commit_template

    # if necessary set you LANG to en_US.UTF-8 or add : alias git='LANG=en_US.UTF-8 git'
	fmt_success "setup git finish!"
}

append_step "setup_git"
