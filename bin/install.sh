#!/usr/bin/env bash


# usage:
# curl -L https://gitee.com/rainytooo/dotfiles/raw/master/bin/setup.sh | bash
# or
# /bin/bash -c "$(curl -fsSL https://gitee.com/rainytooo/dotfiles/raw/master/bin/install.sh)"

set -Eeu -o pipefail

REPO_URL="git@gitee.com:rainytooo/dotfiles.git"


# init some variable
LOG_LEVEL="INFO"                  # INFO DEBUG ERROR


# get the real path of this script
WORKPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"


# ==================================
# Detect OS
# ==================================

OS=`uname -s`
OS_MACH=`uname -m`

detect_os(){
    if [ "${OS}" = "Linux" ] ; then
        OS_KERNEL=$(uname -r)
        if [ -f /etc/redhat-release ] ; then
            OS_DIST='RedHat'
            OS_PSEUDONAME=$(sed s/.*\(// < /etc/redhat-release | sed s/\)//)
            OS_REV=$(sed s/.*release\ // < /etc/redhat-release | sed s/\ .*//)
        elif [ -f /etc/SuSE-release ] ; then
            OS_DIST='SuSe'
            # OS_DIST=$(tr "\n" ' ' < /etc/SuSE-release | sed s/VERSION.*//)
            OS_PSEUDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
            OS_REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
        elif [ -f /etc/mandrake-release ] ; then
            OS_DIST='Mandrake'
            OS_PSEUDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
            OS_REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
            # OS_PSEUDONAME=$(sed s/.*\(// < /etc/mandrake-release | sed s/\)//)
            # OS_REV=$(sed s/.*release\ // < /etc/mandrake-release | sed s/\ .*//)
        elif [ -f /etc/debian_version ] ; then	
            # if [ "$(awk -F= '/DISTRIB_ID/ {print $2}' /etc/lsb-release)" = "Ubuntu" ]; then
            if [ -f /etc/lsb-release ] ; then
                OS_DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
                OS_PSEUDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
                OS_REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
            fi
        elif [ -f /etc/arch-release ] ; then
            OS_DIST="Arch"
            OS_PSEUDONAME=""
            OS_REV=""
        fi
        if [ -f /etc/UnitedLinux-release ] ; then
            OS_DIST="${DIST}[$(tr "\n" ' ' < /etc/UnitedLinux-release | sed s/VERSION.*//)]"
            OS_PSEUDONAME=""
            OS_REV=""
        fi
        OS_INFO="${OS} ${OS_DIST} ${OS_REV}(${OS_PSEUDONAME} ${OS_KERNEL} ${OS_MACH})"
        echo ${OS_INFO}
    elif [ "${OS}" == "Darwin" ]; then
        OS_DIST="OSX"
        type -p sw_vers &>/dev/null
        [ $? -eq 0 ] && {
            OS=`sw_vers | grep 'ProductName' | cut -f 2`
            OS_VER=`sw_vers | grep 'ProductVersion' | cut -f 2`
            OS_BUILD=`sw_vers | grep 'BuildVersion' | cut -f 2`
            OS_INFO="Darwin ${OS} ${VER} ${BUILD}"
        } || {
            OS_INFO="MacOSX"
        }
        echo ${OS_INFO}
    else
        echo "Your Operation System not supported!!"
        exit 1
    fi
    lowcase_os_dist="${$OS_DIST,,}"
}

# ==================================
# utility functions
# ==================================
# abort and exit
abort() {
  printf "%s\n" "$@"
  exit 1
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
print_f_bold="$(print_bold 39)" # use the default forceground color
print_f_reset="$(print_escape 0)"


log_blue()
{
    printf "${print_f_blue}%s${print_f_reset} \n" "$1"
}

log_red()
{
    printf "${print_f_red}%s${print_f_reset} \n" "$1"
}

log_yellow()
{
    printf "${print_f_yellow}%s${print_f_reset} \n" "$1"
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


# ==================================
# setup some environments
# ==================================

check_base_requirement()
{
    # check if user can sudo
    if ! [ sudo -v &> /dev/null ]; then
        log_red "you can not use sudo command, please make sure you can use
        sudo"
        exit 1
    fi

}

# install package on different OS
install_pkg()
{
    case $lowcase_os_dist in
        'ubuntu')
            sudo apt install git
            ;;
        'arch')
            sudo pacman -Sy git
            ;;
        *)
            echo "i can not help you, you must install $1 manually"
            exit 1
            ;;
    esac
}

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
}


run_as_root()
{
    sudo -u root -H bash -c $1
}

# init the package manager
init_pkgm()
{
    case $lowcase_os_dist in
        'ubuntu')
            echo "setup ubuntu apt" ;
            run_as_root "cat $WORKPATH/settings/ubuntu/sources.list > /etc/apt/sources.list"
            sudo apt update && apt upgrade -y
            ;;
        'arch')
            grep -q tsinghua /etc/pacman.d/mirrorlist
            if [ $? ] ; then
                :;
            else
                local arch_source_tsinghua='Server = https://mirror.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch'
                insert_ln=$(grep -Fn Server /etc/pacman.d/mirrorlist | sed -n  '1p' | cut --delimiter=":" --fields=1)
                sed -rn "$insert_ln i $arch_source_tsinghua" /etc/pacman.d/mirrorlist
                unset insert_ln
            fi
            ;;
        *)
            log_red "You must sync your package manager manually"
            exit 1
            ;;
    esac
}

setup_timezone()
{
    log_title "setup timezone!"
    timezone="Asia/shanghai"
    sudo apt install -y tzdata
    sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    run_as_root "echo \"${timezone}\" > /etc/timezone"
    sudo dpkg-reconfigure -f noninteractive tzdata
    # or 
    # sudo timedatectl set-timezone Asia/Shanghai
    timedatectl

}

setup_locale()
{
    log_title "setup locale"
    sudo apt install -y locales \
    && sudo locale-gen en_US.UTF-8 \
    && sudo locale
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
                exit 1
                ;;
        esac
    done
}

setup()
{
    # clear
    init_para
    
    log_blue "============================================"
    log_blue "Start initialization"
    log_blue "============================================"

    log_blue "=====> Step 1: Detect you OS infomation"
    detect_os

    log_blue "=====> Step 2: Check Requirement"
    check_base_requirement

    log_blue "=====> Step 3: Setup system package manager"
    init_pkgm

    log_blue "=====> Step 4: Install and init git"
    init_git
    # install_dev_kits
    # setup_timezone
    # setup_locale
}


setup

# vim:set ft=bash et sts=4 ts=4 sw=4 tw=78:
