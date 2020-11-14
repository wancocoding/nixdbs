#!/usr/bin/env bash

# if [ -z "$PS1" ]; then
#         echo This shell is not interactive
# else
#         echo This shell is interactive
# fi

# printenv

echo "============ Installing dotfiles start! ============"

WORKSPACEDIR=$(pwd)

source ./base.sh

_osname=$(detect_os)

if [ "$_osname" == "linux" ]; then

# """""""""""""""""" Basic settings """"""""""""""""""

# base
	source ./base/install.sh

# zsh
	source ./zsh/install.sh

# homebrew
	source ./brew/install.sh

# develop tools
	source ./tools/install.sh

# Tmux
	source ./tmux/install.sh

# vim
	source ./vim/install.sh

# font
	source ./font/install.sh

# nodejs
	source ./node/install.sh

# python
	source ./python/install.sh

# Go
	source ./go/install.sh

# Java
	source ./java/install.sh

# after all
	sudo apt autoremove
else
	echo "this is not a linux system, quit!"
	return
fi

echo "============ Installing dotfiles Finish! ============"

# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
