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

# ==================================
# Setup zsh
# ==================================
setup_zsh()
{

    echo "Install zsh standalone or setup ohmyzsh?"
    echo " (1) zsh with ohmyzsh[recommend]"
    echo " (2) zsh standalone"
    echo " (0) setup zsh manually later!"
    read -p "your choice: > " input_opts
    case $input_opts in
        1)
            install_ohmyzsh
            runzsh
            ;;
        2)
            install_zsh
            runzsh
            ;;
        0)
            echo "Skip zsh setup."
            return
            ;;
        *)
            log_yellow "Invalid choice, you could setup zsh manually later."
            return
            ;;
    esac
}

runzsh()
{
    log_yellow "Important!!! You may run this script again if you run zsh right now!!!"
    read -p "Do you want to run zsh now? [y|n]: > " user_opts
    case $user_opts in
        y*|Y*) ;;
        n*|N*)
            echo "Not run zsh now..."
            log_yellow "You can run zsh after this script!!"
            return ;;
        *)
            echo "Invalid choice."
            return ;;
    esac
    exec zsh -l
}

install_ohmyzsh()
{
    # see https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh
    # if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # then
    #     if [ -n "${REMOTE_PROXY-}" ]; then
    #         echo "use remote proxy you just set!...${REMOTE_PROXY}"
    #         sh -c "$(curl -x ${REMOTE_PROXY} -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    #     elif [ -n "${GITHUB_PROXY-}" ]; then
    #         echo "use github mirror...${GITHUB_PROXY}"
    #         sh -c "$(curl -fsSL ${GITHUB_PROXY}/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    #     fi
    # fi
    if [ -n "${REMOTE_PROXY-}" ]; then
        echo "use remote proxy you just set!...${REMOTE_PROXY}"
        sh -c "$(curl -x ${REMOTE_PROXY} -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    elif [ -n "${GITHUB_PROXY-}" ]; then
        echo "use github mirror...${GITHUB_PROXY}"
        sh -c "$(curl -fsSL ${GITHUB_PROXY}/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        log_red "install ohmyzsh failed, and no available http proxy or github mirror"
        error_exit
    fi
}


install_zsh()
{
    if ! command_exists zsh; then
        # read -p "Do you want to install zsh now: (y|n) [y] >" input_text
        # if [ x"$input_text" == x'y' ]; then
        #     install_pkg zsh
        # else
        #     log_yellow "Skip install zsh"
        #     return
        # fi
        install_pkg zsh
    else
        echo "zsh already installed!"
    fi
    chsh_zsh
}

chsh_zsh()
{
    # If this user's login shell is already "zsh", do not attempt to switch.
    if [ "$(basename -- "$SHELL")" = "zsh" ]; then
        echo "your already in zsh shell."
        return
    fi
    if ! command_exists chsh; then
        cat <<EOF
I can't change your shell automatically because this system does not have chsh.
${print_f_green}Please manually change your default shell to zsh${print_f_reset}
EOF
        return
    fi

    printf "${print_f_yellow}Do you want to change your default shell to zsh now? [y|n] ${print_f_reset}"

    read -r u_opts
    case $u_opts in
        y*|Y*|"") ;;
        n*|N*)
            echo "Skip this step, not change your shell to zsh"
            return ;;
        *)
            echo "Invalid choice. Shell change skiped."
            return ;;
    esac

    if [ -f /etc/shells ]; then
        shells_file=/etc/shells
    else
        log_red "could not find /etc/shells. Change your shell manually"
        error_exit
    fi

    # check zsh command exist again
    # if zsh command exist, but not in /etc/shells
    if ! zsh=$(command -v zsh) || ! zsh=$(grep '^/.*/zsh' "$shells_file" | tail -n 1); then
        log_yellow "could not find zsh binary file"
        log_yellow "Please change your shell manually."
        return
    fi

    echo "Changing your shell to $zsh..."
    sudo -k chsh -s "$zsh" "$USER"
    # Check if the shell change was successful
    if [ $? -ne 0 ]; then
        log_yellow "chsh zsh unsuccessful. Change your default shell manually."
    else
        export SHELL="$zsh"
        log_green "Shell successful changed to $zsh"
    fi

}


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
# Setup Homebrew
# ==================================
setup_homebrew()
{
    read -p "Would you like to install Homebrew? [y|n]: > " user_opts
    case $user_opts in
        y*|Y*)
           install_homebrew 
           ;;
        n*|N*)
            echo "Skip..."
            return ;;
        *)
            log_yellow "Invalid choice. Skip this step..."
            return ;;
    esac
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
    log_success "Setup Homebrew success"
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
