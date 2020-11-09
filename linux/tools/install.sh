#!/usr/bin/env bash

# install develop tools

echo "===================================================="
echo "            Installing Dev Tools!                   "
echo "===================================================="

echo "======> install git"

if [[ -e "/home/linuxbrew/.linuxbrew/bin/git" ]]; then
	echo "git already installed!"
else
	sudo apt remove git
	brew install git
fi


echo "======> config git"

git config --global user.email "ergal@163.com"
git config --global user.name "wancocoding"



echo "======> install some tools"
echo "htop screenfetch tree ctags xclip ... etc"
brew install htop screenfetch tree ctags xclip



# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
