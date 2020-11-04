#!/usr/bin/env bash

echo "===================================================="
echo "            Installing Zsh oh-my-zsh Start!         "
echo "===================================================="


if [[ -d "$HOME/.oh-my-zsh" ]]; then
	echo "oh-my-zsh already installed"
else
	source ./zsh/ohmyzsh-install.sh
fi

echo "======> remove old zshrc"
rm -rf ~/.zshrc
echo "======> link zshrc"

ln -s $(pwd)/zsh/zshrc.symlink $HOME/.zshrc





# vim:set ft=bash noet sts=4 ts=4 sw=4 tw=78:
