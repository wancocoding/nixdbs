#!/usr/bin/env bash

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
else
	echo "this is not a linUx system, quit!"
	return
fi

echo "============ Installing dotfiles Finish! ============"

# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
