#!/usr/bin/env bash

set -Eeu

NIXDBS_REPO=git@192.168.0.118:dotfiles.git
NIXDBS_HOME=$HOME/.nixdbs

if ! command -v git >/dev/null 2>&1; then
	echo "you must install git first"
fi

git clone $NIXDBS_REPO $NIXDBS_HOME

source $NIXDBS_HOME/bin/boot.sh
