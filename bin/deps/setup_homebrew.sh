#!/usr/bin/env bash

# ==================================
# Setup Homebrew
# ==================================

setup_homebrew()
{
	echo_title "Setup Homebrew"
    read -p "Would you like to install Homebrew? [y|n]: > " user_opts
    case $user_opts in
        y*|Y*)
           install_homebrew 
           ;;
        n*|N*)
            echo "Skip..."
            return ;;
        *)
            fmt_warning "Invalid choice. Skip this step..."
            return ;;
    esac
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
        /bin/bash -c "$(curl -fsSL ${GITHUB_PROXY}/https://github.com/Homebrew/install/raw/HEAD/install.sh)"
    fi
    setup_rcfile_for_homebrew
}

setup_rcfile_for_homebrew()
{
    local brew_env_text=$(cat << VEOF
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
# export HOMEBREW_AUTO_UPDATE_SECS=86400
export HOMEBREW_NO_AUTO_UPDATE=1

VEOF
    )
    # for zsh
    if [ -a $HOME/.zprofile ]; then
        if ! grep -Fxq 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' $HOME/.zprofile ; then
            echo '' >> $HOME/.zprofile
            echo '# ====== Homebrew ====== ' >> $HOME/.zprofile
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zprofile
            echo "$brew_env_text" >> $HOME/.zprofile
        fi
    fi
    # for bash
    if [ -a $HOME/.bashrc ]; then
        if ! grep -Fxq 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' $HOME/.bashrc ; then
            echo '' >> $HOME/.bashrc
            echo '# ====== Homebrew ====== ' >> $HOME/.bashrc
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc
            echo "$brew_env_text" >> $HOME/.bashrc
        fi
    fi
}


append_step "setup_homebrew"
