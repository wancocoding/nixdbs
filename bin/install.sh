#!/usr/bin/env bash

set -Eeu

NIXDBS_REPO=git@192.168.0.118:dotfiles.git
# NIXDBS_REPO=https://github.com/wancocoding/nixdbs.git
NIXDBS_HOME=$HOME/.nixdbs
DITFILES_HOME=$HOME/.dotfiles

# check git
if ! command -v git >/dev/null 2>&1; then
	echo "you must install git first"
	exit 1
fi
# check bash
if [ -z "${BASH_VERSION:-}" ]
then
  echo "Bash is required to interpret this script."
  exit 1
fi

if [ -d $NIXDBS_HOME ];then
	echo "nixdbs already exist!"
	echo "if you want to reinstall it, you can remove $NIXDBS_HOME manually fist"
	exit 1
fi
git clone $NIXDBS_REPO $NIXDBS_HOME

/bin/bash $NIXDBS_HOME/bin/nixdbs.sh
