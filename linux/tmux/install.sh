#!/usr/bin/env bash

# install tmux

echo "===================================================="
echo "            Installing Tmux!                        "
echo "===================================================="

echo "======> install tmux"

if [[ -e "/home/linuxbrew/.linuxbrew/bin/tmux" ]]; then
	echo "tmux already installed!"
else
	sudo apt remove tmux -y 
	brew install tmux
fi


echo "======> config tmux"

git config --global user.email "ergal@163.com"
git config --global user.name "wancocoding"



# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
