#!/usr/bin/env bash


echo "===================================================="
echo "            Installing Base Dependence              "
echo "===================================================="



sudo apt install git gcc make curl wget file unzip -y

echo "======> install build-essential"

sudo apt-get install build-essential -y

echo "======> init submodule"
git submodule update --init --recursive 

# init start file
if [ -e $HOME/.profile ]; then
	if ! grep -qi "My Environment" $HOME/.profile ; then
		echo "# ====== My Environment ======" >> $HOME/.profile
	fi
else
	echo "# ====== My Environment ======" >> $HOME/.profile
fi
if [ -e $HOME/.zshrc ]; then
	if ! grep -qi "My Environment" $HOME/.zshrc ; then
		echo "# ====== My Environment ======" >> $HOME/.zshrc
	fi
else
	echo "# ====== My Environment ======" >> $HOME/.zshrc
fi

# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
