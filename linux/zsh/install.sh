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

# install zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting 




# vim:set ft=bash noet sts=4 ts=4 sw=4 tw=78:
