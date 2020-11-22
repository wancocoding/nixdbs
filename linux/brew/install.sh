#!/usr/bin/env bash

# install homebrew and some basic soft

echo "===================================================="
echo "          Installing Homebrew Start!              "
echo "===================================================="

echo "------ install brew ------"

_brew_installed=$(detect_cmd brew)

if (($_brew_installed)); then
	echo "Homebrew already installed"
	# brew update
else
	echo "Homebrew not installed, install now..."
	source ./brew/brew-install.sh
fi



echo "======> setup brew for zsh"

if grep -iq "linuxbrew" $HOME/.zshrc >/dev/null 2>&1; then
	echo "brew already setup to your profile"
else
	echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> \
		$HOME/.zshrc
fi

source $HOME/.bashrc

echo "======> install gcc"

if (($_brew_installed)); then
	brew -v
	_gcc_installed=$(detect_cmd gcc)
	if (($_gcc_installed)); then
		echo "gcc already installed"
		# brew upgrade gcc
	else
		brew install gcc
	fi
fi

# echo "======> upgrade brew packages"
# brew upgrade

# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
