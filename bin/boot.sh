#!/usr/bin/env bash

# ####################################################
# nixdbs 
# nixdbs is a bootstrap tools to setup a development env quickly
# ####################################################
# usage:
# curl -L https://gitee.com/rainytooo/dotfiles/raw/master/bin/install.sh | bash
# or
# /bin/bash -c "$(curl -fsSL https://gitee.com/rainytooo/dotfiles/raw/master/bin/install.sh)"
# 
# repository in ~/.cocodot/dotfiles
# settings file in ~/.cocodot/settings
# 

set -Eeu -o pipefail



USER=${USER:-$(id -u -n)}

REPO_URL="git@gitee.com:rainytooo/dotfiles.git"

# create a temp directory for 
TMP_FILE="$(mktemp -d)" || exit 1

# get the real path of this script
WORKPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd $WORKPATH

# init variables
source ./deps/variables.sh

# init colors
source ./deps/colors.sh

# logging
source ./deps/logging.sh

# basic functions
source ./deps/base_func.sh

# check requirements
source ./deps/requirements.sh

# detect OS
source ./deps/detect_os.sh

# setup os commands
source ./deps/commands.sh

# update system
source ./deps/init_system.sh

# install base tools
source ./deps/install_base_pkg.sh

# setup a local proxy
source ./deps/setup_local_proxy.sh

# setup git
source ./deps/setup_git.sh

# setup timezone
source ./deps/setup_tz.sh

# setup locale
source ./deps/setup_locale.sh

# setup zsh
source ./deps/setup_zsh.sh

# setup Hoembrew
source ./deps/setup_homebrew.sh




# ==================================
# Setup Development kits
# ==================================

setup_basic_dev_kits()
{
    if [ "${OS}" = "Linux" ] ; then
       if [[ -x "$(command -v apt)" ]] ; then
           log_blue "Debian install build-essential"
           sudo apt install build-essential
       elif command -v pacman > /dev/null ; then
           log_blue "Arch install base-devel"
           sudo pacman -Syu base-devel
       elif command -v dnf > /dev/null ; then
           log_blue "dnf group install [Development Tools] and [Development Libraries]"
           sudo dnf group install "Development Tools" "Development Libraries"
       elif command -v yum > /dev/null ; then
           log_blue "yum group install [Development Tools] and [Development Libraries]"
           sudo yum groupinstall "Development Tools" "Development Libraries"
       elif command -v zypper > /dev/null ; then
           log_blue "Suse sudo zypper install -t pattern devel_basis"
           sudo zypper install -t pattern devel_basis
       elif command -v apk > /dev/null; then
           log_blue "Alpine install build-base"
           sudo apk add build-base
       else
           log_yellow "Your OS not support now!"
           error_exit
       fi
    elif [ "${OS}" == "Darwin" ]; then
        log_blue "execute 'xcode-select --install' on macosx"
        xcode-select --install
    else
        log_yellow "Your OS not support now!"
        error_exit
    fi
}


# ==================================
# Setup C and Cpp Development Kits
# ==================================
# gcc g++ make ninja gdb cmake llvm clangd
setup_c_dev_kits()
{
    echo "Install gcc"
    if command_exists gcc ; then
        echo "gcc exist, Skip..."
    fi
}

# ==================================
# Setup Vim
# ==================================





# install basic development kits
install_dev_kits()
{
    log_title "install basic development kits"
    # color_output 1 "Install basic develop tools and libraries!"
    sudo apt install -y build-essential \
    libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev llvm \
    libncurses5-dev libncursesw5-dev  \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl \
    libmysql++-dev libmysqlclient-dev python-dev
}

comments()
{

    log_blue "=====> Setup system package manager"
    # init_pkgm
    echo "igore this step when debug..."
    log_success "Setup system package manager success"

    log_blue "=====> Check Base Softwares"
    detect_software
    log_success "Setup basic soft success"

    log_blue "=====> Setup proxy"
    setup_proxy
    log_success "Setup proxy success"

    log_blue "=====> Install and init git"
    init_git
    log_success "Setup git success"

    log_blue "=====> Clone dotfiles repository"
    clone_repository

    log_blue "=====> Setup Timezone"
    setup_timezone
    log_success "Setup timezone success"

    log_blue "=====> Setup Language"
    setup_locale
    log_success "Setup locale language success"

    log_blue "=====> Setup Zsh"
    setup_zsh
    log_success "Setup Zsh success"

    log_blue "=====> Setup Basic Development Kits"
    setup_basic_dev_kits
    log_success "Setup Basic Development Kits success"

    log_blue "======> Setup C and Cpp Development kits"
    setup_c_dev_kits

    log_blue "======> Setup Homebrew"
    setup_homebrew

    log_blue "=====> Setup Vim/NeoVim"
    # setup_vim
    log_success "Setup Vim/NeoVim success"

}



finish_exit

# vim:set ft=bash et sts=4 ts=4 sw=4 tw=78:
