#!/usr/bin/env bash

set -Eeu -o pipefail


# init some variable
LOG_LEVEL="INFO"                  # INFO DEBUG ERROR


# get the real path of this script
WORKPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"



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

# check git installed
if ! command -v git 1>/dev/null 2>&1; then
  echo "pyenv: Git is not installed, now install git " >&2
  sudo apt install -y git
fi


# ==================================
# setup some environments
# ==================================

function run_as_root()
{
    sudo -u root -H bash -c $1
}

# init the package manager
function init_pkgm()
{
    run_as_root "cat $WORKPATH/settings/ubuntu/sources.list > /etc/apt/sources.list"
    sudo apt update && apt upgrade -y
}

function setup_timezone()
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

function setup_locale()
{
    log_title "setup locale"
    sudo apt install -y locales \
    && sudo locale-gen en_US.UTF-8 \
    && sudo locale
}

# install basic development kits
function install_dev_kits()
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

function main()
{
    init_para
    # install_dev_kits
    # setup_timezone
    # setup_locale
    printf "${print_f_red}Hello ${print_f_reset}world \n"
}



main


