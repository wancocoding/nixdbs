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

REPO_URL="https://github.com/wancocoding/nixdbs.git"

NIXDBS_HOME=$HOME/.nixdbs

# create a temp directory
TMP_FILE="$(mktemp -d)" || exit 1

NIXDBS_CACHE_STEP_FILE=$HOME/.cache/nixdbs/run_steps

mkdir -p $HOME/.cache/nixdbs >/dev/null 2>&1
[ -f $NIXDBS_CACHE_STEP_FILE ] || touch $NIXDBS_CACHE_STEP_FILE 

# get the real path of this script
WORKPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd $WORKPATH

# parse options
source ./deps/opts.sh

# =========== These steps are required

source ./deps/install_nixdbs.sh

# init variables
source ./deps/variables.sh

# basic functions
source ./deps/base_func.sh

# init colors
source ./deps/colors.sh

# logging
source ./deps/logging.sh

# check requirements
source ./deps/requirements.sh

# detect OS
source ./deps/detect_os.sh

# setup os commands
source ./deps/commands.sh

#=========== These steps are optional

# setup os package mirror
source ./deps/setup_os_mirror.sh

# setup a local proxy
source ./deps/setup_http_proxy.sh

# update system
source ./deps/init_system.sh

# install base tools
source ./deps/install_base_pkg.sh

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

# install tools
source ./deps/install_tools.sh

# =========== Develop Languages and Tools
# setup vim
source ./deps/setup_vim.sh

# setup c cpp
source ./deps/setup_lang_c.sh

# setup nvm and node
source ./deps/setup_lang_node.sh

# setup python and pyenv
source ./deps/setup_lang_py.sh

# setup ruby and rbenv
source ./deps/setup_lang_rb.sh

# setup jdk and gradle
source ./deps/setup_lang_java.sh

# setup golang
source ./deps/setup_lang_go.sh

main_step

finish_exit

# vim:set ft=bash et sts=4 ts=4 sw=4 tw=78:
