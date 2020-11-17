#!/usr/bin/env bash

# install develop tools

echo "===================================================="
echo "            Installing Dev Tools!                   "
echo "===================================================="

# echo "======> install git"

# if [[ -e "/home/linuxbrew/.linuxbrew/bin/git" ]]; then
# 	echo "git already installed!"
# else
# 	sudo apt remove git
# 	brew install git
# fi


echo "======> config git"

git config --global user.email "ergal@163.com"
git config --global user.name "wancocoding"



echo "======> install some tools"
echo "htop screenfetch tree ctags xclip ... etc"
brew install htop screenfetch tree ctags xclip fzf ripgrep fd

$(brew --prefix)/opt/fzf/install

echo "======> install hugo"
_hugo_installed=$(detect_cmd hugo)


if (($_hugo_installed)); then
	echo "hugo already installed, try to upgradle!"
	brew upgrade hugo
else
	brew install hugo
fi

echo "======> install peek for record screen"
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek -y


# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
