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

# install base dev kits packages
source ./deps/setup_dev_base_kits.sh

# setup vim
source ./deps/setup_vim.sh

finish_exit

# vim:set ft=bash et sts=4 ts=4 sw=4 tw=78:
