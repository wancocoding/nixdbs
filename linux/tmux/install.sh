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


echo "======> link tmux config"
rm -rf $HOME/.tmux.conf >/dev/null 2>&1
ln -s $(pwd)/tmux/tmux.conf.symlink $HOME/.tmux.conf
rm -rf $HOME/.tmux >/dev/null 2>&1
ln -s $(pwd)/tmux/tmux.symlink $HOME/.tmux


# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
