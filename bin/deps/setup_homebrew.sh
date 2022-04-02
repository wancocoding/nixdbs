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
    if [ -a $HOME/.profile ]; then
        if ! grep -Fxq 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' $HOME/.profile ; then
            echo '' >> $HOME/.profile
            echo '# ====== Homebrew ====== ' >> $HOME/.profile
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
            echo "$brew_env_text" >> $HOME/.profile
        fi
    elif [ -a $HOME/.bash_profile ]; then
        if ! grep -Fxq 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' $HOME/.bash_profile ; then
            echo '' >> $HOME/.bash_profile
            echo '# ====== Homebrew ====== ' >> $HOME/.bash_profile
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bash_profile
            echo "$brew_env_text" >> $HOME/.bash_profile
        fi
    fi
}


setup_homebrew
