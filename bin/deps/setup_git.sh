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

    if [ -n "${REMOTE_PROXY-}" ]; then
        git config --global http.proxy $REMOTE_PROXY
    fi
    # common git settings
    git config --global core.autocrlf false
    git config --global core.eol lf
    git config --global pull.rebase true
    git config --global core.editor vim
		git config --global core.filemode false
		git config --global merge.tool vimdiff
		git config --global mergetool.prompt false
		git config --global mergetool.keepbackup false


    # git alias settings
    # git push
    git config --global alias.p 'push'

    # git status
    git config --global alias.st 'status -sb'

    # git log
    git config --global alias.ll 'log --oneline'
    git config --global alias.lla 'log --oneline --decorate --graph --all'

    # last commit
    git config --global alias.last 'log -1 HEAD --stat'

    # git commit
    git config --global alias.cm 'commit'
    git config --global alias.cmm 'commit -m'

    # git checkout
    git config --global alias.co 'checkout'

    # git remote
    git config --global alias.rv 'remote -v'

    # git diff 
    git config --global alias.d 'diff'
    git config --global alias.dv 'difftool -t vimdiff -y'

    # list git global config
    git config --global alias.gl 'config --global -l'

    # git branch
    git config --global alias.br "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"

    # reset last 
    git config --global alias.undo 'reset HEAD~1 --mixed'
    
    # if necessary set you LANG to en_US.UTF-8 or add : alias git='LANG=en_US.UTF-8 git'
		fmt_success "setup git finish!"
}

setup_git
