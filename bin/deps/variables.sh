#!/bin/bash

# ==================================
# variables
# ==================================

# install path
NIXDBS_HOME=$HOME/.nixdbs
NIXDBS_REPO=https://github.com/wancocoding/nixdbs.git
# NIXDBS_REPO=https://github.com/wancocoding/nixdbs.git

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

# GITHUB_PROXY="https://ghproxy.com"

# v2fly/v2ray 
V2RAY_VERSION="v4.44.0" # this will be update when proxy install success
V2RAY_RELEASE="https://github.com/v2fly/v2ray-core/releases/download/${V2RAY_VERSION}/v2ray-linux-64.zip"
# V2RAY_RELEASE_PROXY="${GITHUB_PROXY}/${V2RAY_RELEASE}"
V2RAY_INSTALL_SCRIPT="https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh"
# V2RAY_INSTALL_SCRIPT_PROXY="${GITHUB_PROXY}/${V2RAY_INSTALL_SCRIPT}"

MANJARO_MIRROR='Server = https://mirrors.tuna.tsinghua.edu.cn/manjaro/stable/$repo/$arch'
ARCH_MIRROR='Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch'

UBUNTU_MIRROR="$(cat << EOF
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse

# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
EOF
)"


TIMEZONE="Asia/shanghai"

HOMEBREW_SETTINGS="$(cat << HBEOF
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_NO_AUTO_UPDATE=1
HBEOF
)"


VIM_PLUG_VIMFILE_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
# VIM_PLUG_VIMFILE_URL_PROXY="${GITHUB_PROXY}/$VIM_PLUG_VIMFILE_URL"

GLOBAL_NODE_VERSION="gallium"

# default python version to install by pyenv
PYENV_DEFAULT_PY_VERSION="3.9.12"

# default ruby version by rbenv install
RBENV_DEFALUT_RUBY_VERSION="3.1.1"

# default jdk version 17.0.3 - AdoptOpenJDK(Eclipse Adoptium Temurin)
JDK_DEFAULT_VERSION="17.0.3-tem"
GRADLE_DEFAULT_VERSION="7.4.2"

# setup steps
declare -a SETUP_STEPS_ARRAY
