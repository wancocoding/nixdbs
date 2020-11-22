#!/usr/bin/env bash

echo "===================================================="
echo "            Installing Zsh oh-my-zsh Start!         "
echo "===================================================="


if [[ -d "$HOME/.oh-my-zsh" ]]; then
	echo "oh-my-zsh already installed"
	echo "use ohmyzsh mirror china!"
	echo "set ohmyzsh repo to gitee"
	cd $HOME/.oh-my-zsh
	git remote set-url origin https://gitee.com/mirrors/oh-my-zsh.git
	cd $WORKSPACEDIR
else
	source ./zsh/ohmyzsh-install.sh
fi


rm -rf ~/.dotfiles 2>/dev/null
ln -s "$WORKSPACEDIR" $HOME/.dotfiles

# init start file
if [ -e $HOME/.zshrc ]; then
	if ! grep -qi "My Environment" $HOME/.zshrc ; then
		echo "# ====== My Environment ======" >> $HOME/.zshrc
	fi
else
	echo "# ====== My Environment ======" >> $HOME/.zshrc
fi

echo "======> remove old zshrc"
rm -rf ~/.zshrc 2> /dev/null

echo "======> link zshrc"
ln -s $(pwd)/zsh/zshrc.symlink $HOME/.zshrc


if grep -iq 'user apps path settings' $HOME/.zshrc >/dev/null 2>&1; then
    echo "apps bin path already setup to your profile"
else
    echo '# ====== user apps path settings ======' >> $HOME/.zshrc
    echo 'export PATH=$HOME/apps/bin:$HOME/.dotfiles/sbin:$PATH' >> $HOME/.zshrc
fi

if grep -iq 'My Environment' $HOME/.bashrc >/dev/null 2>&1; then
    echo "bash rcfile already setup!"
else
    cat bash/bashrc >> $HOME/.bashrc
fi

source $HOME/.bashrc

# install zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting 


# vim:set ft=bash noet sts=4 ts=4 sw=4 tw=78:
