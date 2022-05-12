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

# deprecated, use mirror settings file in misc/mirrors/[area]/pkg/homebrew instead
HOMEBREW_SETTINGS="$(cat << HBEOF
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_NO_AUTO_UPDATE=1
HBEOF
)"


FZF_SETTINGS="$(cat << FZFEOF
# fd
export FD_OPTIONS="--follow --exclude .git --exclude node_modules"
# export FZF_DEFAULT_OPTS="--no-mouse --border --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | xclip -i -sel clip)'"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules}/*" 2>/dev/null'
export FZF_ALT_C_COMMAND="rg --sort-files --files --null 2>/dev/null | xargs -0 dirname | uniq"
FZFEOF
)"

FZF_SETTINGS_CONS='export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"'

# Deprecated, use mirror config file instead. 
GEMRC_SETTINGS="$(cat << GREOF
---
:backtrace: false
:bulk_threshold: 1000
:sources:
- https://mirrors.aliyun.com/rubygems/
- https://mirrors.tuna.tsinghua.edu.cn/rubygems/
- https://gems.ruby-china.com/
:update_sources: true
:verbose: true
:concurrent_downloads: 8
GREOF
)"

# Deprecate, set by mirror settings in misc/mirrors/[area]/pkg/npm
NPMRC_SETTINGS="registry=https://registry.npm.taobao.org/"

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

GOLANG_DEFAULT_VERSION="go1.18.1"

# setup all tasks
declare -a SETUP_TASKS_ARRAY
