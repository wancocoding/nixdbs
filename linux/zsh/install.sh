#!/usr/bin/env bash

echo "===================================================="
echo "            Installing Zsh oh-my-zsh Start!         "
echo "===================================================="


if [[ -d "$HOME/.oh-my-zsh" ]]; then
	echo "oh-my-zsh already installed"
else
	source ./zsh/ohmyzsh-install.sh
fi


rm -rf ~/.dotfiles 2>/dev/null
ln -s "$WORKSPACEDIR" $HOME/.dotfiles

# init start file
if [ -e $HOME/.profile ]; then
	if ! grep -qi "My Environment" $HOME/.profile ; then
		echo "# ====== My Environment ======" >> $HOME/.profile
	fi
else
	echo "# ====== My Environment ======" >> $HOME/.profile
fi

echo "======> remove old zshrc"
rm -rf ~/.zshrc 2> /dev/null

echo "======> link zshrc"
ln -s $(pwd)/zsh/zshrc.symlink $HOME/.zshrc

if [ -e $HOME/.zshrc ]; then
	if ! grep -qi "My Environment" $HOME/.zshrc ; then
		echo "# ====== My Environment ======" >> $HOME/.zshrc
	fi
fi

if grep -iq 'export PATH=$HOME/apps/bin:$PATH' $HOME/.profile >/dev/null 2>&1; then
    echo "apps bin path already setup to your profile"
else
    echo 'export PATH=$HOME/apps/bin:$HOME/.dotfiles/sbin:$PATH' >> $HOME/.profile
    echo 'export PATH=$HOME/apps/bin:$HOME/.dotfiles/sbin:$PATH' >> $HOME/.zshrc
fi

source $HOME/.zshrc

# install zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting 




# vim:set ft=bash noet sts=4 ts=4 sw=4 tw=78:
