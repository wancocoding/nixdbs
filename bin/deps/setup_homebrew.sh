#!/usr/bin/env bash

# ==================================
# Setup Homebrew
# ==================================

setup_homebrew()
{
	echo_title "Setup Homebrew"
    # read -p "Would you like to install Homebrew? [y|n]: > " user_opts
    # case $user_opts in
    #     y*|Y*)
    #        install_homebrew 
    #        ;;
    #     n*|N*)
    #         echo "Skip..."
    #         return ;;
    #     *)
    #         fmt_warning "Invalid choice. Skip this step..."
    #         return ;;
    # esac
	install_homebrew 

    setup_rcfile_for_homebrew

	fmt_success "finish setup homebrew."
}

install_homebrew()
{
    if command_exists brew || [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
        echo "You have installed Homebrew already! Skip this step."
    else
        export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
        export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
        export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
		local http_proxy=$(get_http_proxy)
		if [ ! -z "${http_proxy:-}" ]; then
			echo "install brew by http proxy"
			/bin/bash -c "$(curl --proxy $http_proxy -fsSL https://github.com/Homebrew/install/raw/HEAD/install.sh)"
		else
			/bin/bash -c "$(curl -fsSL https://github.com/Homebrew/install/raw/HEAD/install.sh)"
		fi
    fi
}

setup_rcfile_for_homebrew()
{
	fmt_info "setup rcfile for homebrew"
    local brew_env_text=$(cat << VEOF
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
# export HOMEBREW_AUTO_UPDATE_SECS=86400
export HOMEBREW_NO_AUTO_UPDATE=1

VEOF
    )
    # for zsh
    if [ -a $HOME/.zshrc ]; then
        if ! grep -Fxq 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' $HOME/.zshrc ; then
            echo '' >> $HOME/.zshrc
            echo '# ====== Homebrew ====== ' >> $HOME/.zshrc
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zshrc
            echo "$brew_env_text" >> $HOME/.zshrc
		else
			echo "homebrew env already exist."
        fi
    fi
    # for bash
    if [ -a $HOME/.bashrc ]; then
        if ! grep -Fxq 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' $HOME/.bashrc ; then
            echo '' >> $HOME/.bashrc
            echo '# ====== Homebrew ====== ' >> $HOME/.bashrc
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc
            echo "$brew_env_text" >> $HOME/.bashrc
		else
			echo "homebrew env already exist."
        fi
    fi
	eval "$brew_env_text"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
}


append_step "setup_homebrew"
