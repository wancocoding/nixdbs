#!/usr/bin/env bash


# usage:
# curl -L https://gitee.com/rainytooo/dotfiles/raw/master/bin/install.sh | bash
# or
# /bin/bash -c "$(curl -fsSL https://gitee.com/rainytooo/dotfiles/raw/master/bin/install.sh)"
# local DEBUG
# 

set -Eeu -o pipefail



USER=${USER:-$(id -u -n)}

REPO_URL="git@gitee.com:rainytooo/dotfiles.git"

# create a temp directory for 
TMP_FILE="$(mktemp -d)" || exit 1


# get the real path of this script
WORKPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo "your workspace path is $WORKPATH"

# ==================================
# useful variables
# ==================================

# github mirror
# usage:
#   [clone]
#   git clone https://ghproxy.com/https://github.com/stilleshan/ServerStatus
#   [file]
#   wget https://ghproxy.com/https://github.com/stilleshan/ServerStatus/archive/master.zip
#   curl -O https://ghproxy.com/https://github.com/stilleshan/ServerStatus/archive/master.zip
#   [raw content]
#   wget https://ghproxy.com/https://raw.githubusercontent.com/stilleshan/ServerStatus/master/Dockerfile
#   curl -O https://ghproxy.com/https://raw.githubusercontent.com/stilleshan/ServerStatus/master/Dockerfile
GITHUB_PROXY="https://ghproxy.com"

# v2fly/v2ray 
V2RAY_VERSION="v4.44.0" # this will be update when proxy install success
V2RAY_RELEASE="https://github.com/v2fly/v2ray-core/releases/download/${V2RAY_VERSION}/v2ray-linux-64.zip"
V2RAY_RELEASE_PROXY="${GITHUB_PROXY}/${V2RAY_RELEASE}"
V2RAY_INSTALL_SCRIPT="https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh"
V2RAY_INSTALL_SCRIPT_PROXY="${GITHUB_PROXY}/${V2RAY_INSTALL_SCRIPT}"

# ==================================
# Preparation
# ==================================

# Require Bash
if [ -z "${BASH_VERSION:-}" ]
then
  abort "Bash is required to interpret this script."
fi

# check not call from subshell
if [ -t 1 ]; then
  is_tty() {
    true
  }
else
  is_tty() {
    false
  }
fi

# ==================================
# utility functions
# ==================================

command_exists() {
  command -v "$@" >/dev/null 2>&1
}
# abort and exit
abort() {
  printf "%s\n" "$@"
  exit 1
}

error_exit()
{
    log_yellow "Finish this job, but some error occurred!"
    # remove temp file 
    rm -rf $TMP_FILE &> /dev/null
    exit 1
}

finish_exit()
{
    rm -rf $TMP_FILE &> /dev/null
    exit 0
}

# 解析参数 
#   v verbose模式
init_para()
{
    while getopts 'vhp:' script_args; do
        case "$script_args" in
            v)
                LOG_LEVEL="DEBUG";
                ;;
            p)
                echo "set the git proxy."
                git config --global http.proxy ${OPTARG}
                ;;
            h)
                usage_help
                finish_exit
                ;;
        esac
    done
}

# output formatting
# check if it is standard output
if [[ -t 1 ]]; then
    print_escape() { printf "\033[%sm" "$1"; }
else
    print_escape() { :; }
fi

print_bold()
{
    print_escape "1;$1" ;
}

print_underline()
{
    print_escape "4;$1" ;
}
print_f_red="$(print_bold 31)"
print_f_yellow="$(print_bold 33)"
print_f_blue="$(print_bold 34)"
print_f_green="$(print_bold "38;5;82")" # use the default forceground color
print_f_bold="$(print_bold 39)" # use the default forceground color
print_f_reset="$(print_escape 0)"

# information
log_blue()
{
    printf "${print_f_blue}%s${print_f_reset} \n" "$1"
}
# error
log_red()
{
    printf "${print_f_red}%s${print_f_reset} \n" "$1"
}
# warning
log_yellow()
{
    printf "${print_f_yellow}%s${print_f_reset} \n" "$1"
}
# success
log_green()
{
    printf "${print_f_green}%s${print_f_reset} \n" "$1"
}


log_success()
{
    printf "${print_f_green}[ ok ] ${print_f_reset} %s \n" "$1"
}

# show script usage
usage_help()
{
    # Display Help
    echo "Add description of the script functions here."
    echo
    echo "Syntax: install.sh [-p|h|v|V]"
    echo "options:"
    echo " -p        set the git proxy. eg: http://192.168.0.114:9081"
    echo " -h        Print this Help."
    echo " -v        Verbose mode."
    echo " -V        Print software version and exit."
    echo
}

# format the command and args for print
format_cmd()
{
    local exe_arg
    printf "%s" "$1"
    shift
    for exe_arg in "$@"
    do
        printf " "
        # replace all space
        printf "%s" "${exe_arg// /\ }"
    done
}

# logging execute commands
debug_cmd()
{
    printf "${print_f_blue}[command] %s${print_f_reset}\n" "$(format_cmd "$@")"
}


# execute command
# log command before execute
exe_cmd()
{
    if ! "$@" ; then
        abort "$(printf "Failed during: %s" "$(format_cmd "$@")")"
    fi
}

exe_sudo_cmd()
{
    # local -a args=("$@")
    # # debug
    # for cmdi in "${args[@]}"
    # do
    #     echo "===="
    #     echo "$cmdi"
    # done
    # debug_cmd "/usr/bin/sudo" "${args[@]}"
    # exe_cmd "/usr/bin/sudo" "${args[@]}"

    debug_cmd "/usr/bin/sudo" "/bin/bash" "-c" "$@"
    exe_cmd "/usr/bin/sudo" "/bin/bash" "-c" "$(format_cmd "$@")"
}

run_as_root()
{
    sudo -u root -H bash -c $1
}


# ==================================
# Detect OS Information
# ==================================

OS=`uname -s`
OS_MACH=`uname -m`
OS_KERNEL=`uname -r`


OS_PSEUDONAME=""
OS_REV=""

detect_os(){
    if [ "${OS}" = "Linux" ] ; then
        OS_KERNEL=$(uname -r)
        if [ -f /etc/redhat-release ] ; then
            OS_DIST='RedHat'
            OS_PSEUDONAME=$(sed s/.*\(// < /etc/redhat-release | sed s/\)//)
            OS_REV=$(sed s/.*release\ // < /etc/redhat-release | sed s/\ .*//)
            if [[ -x "$(command -v dnf)" ]]; then
                PACKAGE_INSTALL_CMD="dnf -y install"
                # SYNC_SYSTEM_PACKAGE_CMD='apt update && apt upgrade -y'
            elif [[ -x "$(command -v yum)" ]]; then
                PACKAGE_INSTALL_CMD="yum -y install"
            else
                log_yellow "No yum or dnf in this system!"
                error_exit
            fi
            SYNC_SYSTEM_PACKAGE_CMD="echo 'no need to update system!'"
        elif [ -f /etc/SuSE-release ] ; then
            OS_DIST='SuSe'
            # OS_DIST=$(tr "\n" ' ' < /etc/SuSE-release | sed s/VERSION.*//)
            OS_PSEUDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
            OS_REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
            PACKAGE_INSTALL_CMD="zypper install -y --no-recommends"
            SYNC_SYSTEM_PACKAGE_CMD="zypper update -y"
        # elif [ -f /etc/mandrake-release ] ; then
        #     OS_DIST='Mandrake'
        #     OS_PSEUDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
        #     OS_REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
        #     PACKAGE_INSTALL_CMD='dnf -y install'
        #     # OS_PSEUDONAME=$(sed s/.*\(// < /etc/mandrake-release | sed s/\)//)
        #     # OS_REV=$(sed s/.*release\ // < /etc/mandrake-release | sed s/\ .*//)
        elif [ -f /etc/debian_version ] ; then	
            # if [ "$(awk -F= '/DISTRIB_ID/ {print $2}' /etc/lsb-release)" = "Ubuntu" ]; then
            if [ -f /etc/lsb-release ] ; then
                OS_DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
                OS_PSEUDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
                OS_REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
                PACKAGE_INSTALL_CMD="apt -y --no-install-recommends install"
                SYNC_SYSTEM_PACKAGE_CMD="apt update && apt upgrade -y"
            else
                log_yellow "Can not recognize your debain distribute"
                error_exit
            fi
        elif [ -f /etc/arch-release ] ; then
            OS_DIST="Arch"
            PACKAGE_INSTALL_CMD="pacman -Syu --noconfirm"
            SYNC_SYSTEM_PACKAGE_CMD="pacman -Syu"
        elif [ -f /etc/alpine-release ] ; then
            OS_DIST="Alpine"
            OS_REV=`cat /etc/alpine-release`
            PACKAGE_INSTALL_CMD="apk add"
            SYNC_SYSTEM_PACKAGE_CMD="apk update"
        fi
        if [ -f /etc/UnitedLinux-release ] ; then
            # OS_DIST="${DIST}[$(tr "\n" ' ' < /etc/UnitedLinux-release | sed s/VERSION.*//)]"
            log_yellow "Not sure your system is supported!"
            error_exit
        fi
        OS_INFO="${OS} ${OS_DIST} ${OS_REV}(${OS_PSEUDONAME} ${OS_KERNEL} ${OS_MACH})"
    elif [ "${OS}" == "Darwin" ]; then
        OS_DIST="OSX"
        type -p sw_vers &>/dev/null
        [ $? -eq 0 ] && {
            OS=`sw_vers | grep 'ProductName' | cut -f 2`
            OS_REV=`sw_vers | grep 'ProductVersion' | cut -f 2`
            OS_BUILD=`sw_vers | grep 'BuildVersion' | cut -f 2`
            OS_INFO="${OS} ${OS_DIST} ${OS_REV} ${OS_BUILD}"
        } || {
            OS_INFO="MacOSX"
        }
    else
        echo "Your Operation System not supported!!"
        error_exit
    fi
    # lowcase_os_dist="${OS_DIST,,}"
    lowcase_os_dist=$(echo $OS_DIST | awk '{print tolower($0)}')
    echo "Your system information:"
    echo -e "  Marchine:            ${OS}"
    echo -e "  Dist:                ${OS_DIST}"
    echo -e "  Version:             ${OS_REV}"
    echo -e "  Architecture:        ${OS_MACH}"
    echo -e "  Kernel:              ${OS_KERNEL}"
    echo ${OS_INFO}
}


# ==================================
# Setup package managment
# ==================================

# install package on different OS
install_pkg()
{
    local -a install_packages_arr=("$@")
    install_cmd_args=("${PACKAGE_INSTALL_CMD}" "${install_packages_arr[@]}")
    exe_sudo_cmd "${install_cmd_args[@]}"
    # case $lowcase_os_dist in
    #     'ubuntu')
    #         exe_sudo_cmd apt install git
    #         ;;
    #     'arch')
    #         exe_sudo_cmd pacman -Sy git
    #         ;;
    #     *)
    #         echo "I can not help you, you must install $1 manually"
    #         error_exit
    #         ;;
    # esac
}

sync_and_update_system_pkg()
{
    log_blue "Sync and upgrade your system now!"
    if [ -n "${SYNC_SYSTEM_PACKAGE_CMD-}" ]; then
        exe_sudo_cmd "${SYNC_SYSTEM_PACKAGE_CMD}"
    fi
}

# init the package manager
init_pkgm()
{
    case $lowcase_os_dist in
        'ubuntu')
            echo "setup ubuntu repository mirror to tsinghua"
            sudo -u root /bin/bash -c "cat $WORKPATH/../settings/ubuntu/sources.list > /etc/apt/sources.list"
            sync_and_update_system_pkg
            ;;
        'arch')
            echo "setup archlinux repository mirror to tsinghua"
            # sudo grep -q 'tsinghua' /etc/pacman.d/mirrorlist
            if grep -q tsinghua /etc/pacman.d/mirrorlist ; then
                echo "tsinghua mirror already existed!"
            else
                echo "tsinghua mirror server not existed, now add it."
                arch_source_tsinghua='Server = https://mirror.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch'
                insert_ln=$(grep -Fn Server /etc/pacman.d/mirrorlist | sed -n  '1p' | cut --delimiter=":" --fields=1)
                exe_sudo_cmd sed -i "$insert_ln i $arch_source_tsinghua" /etc/pacman.d/mirrorlist
                unset insert_ln
                unset arch_source_tsinghua
            fi
            echo "Now update pacman"
            sync_and_update_system_pkg
            ;;
        'alpine')
            echo "setup alpine repository mirror to tsinghua or bfsu(Beiwai)"
            if grep -q tsinghua /etc/apk/repositories ; then
                echo "tsinghua mirror already existed!"
            else
                exe_sudo_cmd "sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories"
                # sed -i 's/dl-cdn.alpinelinux.org/mirrors.bfsu.edu.cn/g' /etc/apk/repositories
            fi
            sync_and_update_system_pkg
            ;;
        *)
            log_yellow "You must sync your package manager manually"
            ;;
    esac
}


# ==================================
# Detect Requirements
# ==================================

detect_bash()
{
    if [ -z "${BASH_VERSION:-}" ]; then
        log_red "Bash is required!, You must install it first"
        error_exit
    fi
}

detect_sudo()
{
    if [[ ! -x "/usr/bin/sudo" ]]; then
        log_red "You must install sudo first"
        error_exit
    fi
    # check if user can sudo
    if ! sudo -v &> /dev/null ; then
        log_red "you can not use sudo command, please make sure you have sudo privileges"
        error_exit
    fi
}

check_base_requirement()
{
    detect_bash
    detect_sudo
}


# ==================================
# Detect Software (need: curl and unzip)
# ==================================
detect_software()
{
    echo "Checking curl and unzip"
    if ! command -v curl > /dev/null ; then
        echo "No curl in your system, now try to install it"
        local -a pkg_arr=("curl")
        install_pkg "${pkg_arr[@]}"
        unset pkg_arr
    else
        echo "curl already installed!"
    fi
    if ! command -v unzip > /dev/null ; then
        echo "No unzip in your system, now try to install it"
        install_pkg "unzip"
    else
        echo "curl already installed!"
    fi
}

# ==================================
# Setup Proxy
# ==================================

setup_proxy()
{
    echo "Setup a local proxy or just add a proxy server?"
    echo " (1) local proxy server"
    echo " (2) remote proxy socket or http server"
    echo " (0) ignore, setup proxy server later!"
    read -p "your choice: > " input_text
    if [ ! -z $input_text ] && [ $input_text != " " ]; then
        if [ $input_text -eq 0 ]; then
            echo "you decide setup proxy server later!"
        elif [ $input_text -eq 1 ]; then
            echo "setup a local proxy!"
        elif [ $input_text -eq 2 ]; then
            echo "setup a remote proxy"
            echo "Please enter your remote proxy url"
            echo "eg: http://192.168.0.114:9081"
            read -p "> " input_text
            if [ ! -z $input_text ] && [ $input_text != "" ]; then
                REMOTE_PROXY=$input_text
                log_green "your proxy is: $REMOTE_PROXY"
            fi
        else
            :;
        fi
    else
        log_red "your proxy setting failed!"
    fi
}

setup_local_proxy()
{
    V2RAY_TEMP_DIR="$(mktemp -d)" || exit 1
    cd $V2RAY_TEMP_DIR
    # download install script
    curl -O "$V2RAY_INSTALL_SCRIPT_PROXY"
    # download the v2ray
    curl -O "$V2RAY_RELEASE_PROXY"
    /bin/bash install-release.sh -l v2ray-linux-64.zip
    cd /tmp
    rm -rf $V2RAY_TEMP_DIR
}


# ==================================
# Setup Git
# ==================================

# check git installed
init_git()
{
    if ! command -v git 1>/dev/null 2>&1; then
        echo "Git is not installed, now install git " >&2
        install_pkg git
    else
        echo "git already installed"
    fi
    echo "now configure git"
    read -p "enter your name[coco]: > " input_text
    if [ ! -z $input_text ] && [ $input_text != " " ]; then
        git config --global user.name "$input_text"
    else
        log_yellow "you should setup your git config [user.name] later!"
    fi
    read -p "enter your email[ohergal@gmail.com]: > " input_text
    if [ ! -z $input_text ] && [ $input_text != " " ]; then
        git config --global user.email "$input_text"
    else
        log_yellow "you should setup your git config [user.email] later!"
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
}



# ==================================
# Setup timezone
# ==================================

setup_timezone()
{
    timezone="Asia/shanghai"
    if [ $lowcase_os_dist == "alpine" ]; then
        install_pkg tzdata
        exe_sudo_cmd "ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime"
        exe_sudo_cmd "echo \"${timezone}\" > /etc/timezone"
    else
            # exe_sudo_cmd "ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime"
            # exe_sudo_cmd "echo \"${timezone}\" > /etc/timezone"
            # exe_sudo_cmd "dpkg-reconfigure -f noninteractive tzdata"
            # or 
            # sudo timedatectl set-timezone Asia/Shanghai
        if command -v timedatectl > /dev/null ; then
            exe_sudo_cmd "timedatectl set-timezone Asia/Shanghai"
            exe_sudo_cmd "timedatectl"
        else
            log_yellow "your timezone setup failed, you should set timezone manually later"
        fi
    fi
}

# ==================================
# Setup locale
# ==================================

setup_locale()
{
    if command -v localectl > /dev/null ; then
        exe_sudo_cmd "localectl set-locale LANG=en_US.UTF-8"
        exe_sudo_cmd "localectl"
    else
        log_yellow "You should set locale manually later"
    fi
    # sudo apt install -y locales \
    # && sudo locale-gen en_US.UTF-8 \
    # && sudo locale
}

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


main()
{
    # clear
    init_para

    log_blue "============================================"
    log_blue "Start initialization"
    log_blue "============================================"

    log_blue "=====> Step 1: Detect you OS infomation"
    detect_os
    log_success "Detect OS success"

    log_blue "=====> Step 2: Check Requirement"
    check_base_requirement
    log_success "Check requirements success"

    log_blue "=====> Step 3: Setup system package manager"
    # init_pkgm
    echo "igore this step when debug..."
    log_success "Setup system package manager success"

    log_blue "=====> Step 4: Check Base Softwares"
    detect_software
    log_success "Setup basic soft success"

    log_blue "=====> Step 5: Setup proxy"
    setup_proxy
    log_success "Setup proxy success"

    log_blue "=====> Step 6: Install and init git"
    init_git
    log_success "Setup git success"

    log_blue "=====> Step 7: Setup Timezone"
    setup_timezone
    log_success "Setup timezone success"

    log_blue "=====> Step 8: Setup Language"
    setup_locale
    log_success "Setup locale language success"

    log_blue "=====> Step 9: Setup Zsh"
    setup_zsh
    log_success "Setup Zsh success"

    log_blue "=====> Step 10: Setup Basic Development Kits"
    setup_basic_dev_kits
    log_success "Setup Basic Development Kits success"
}


main
finish_exit

# vim:set ft=bash et sts=4 ts=4 sw=4 tw=78:
