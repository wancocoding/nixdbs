#!/bin/bash

install_nixdbs()
{

	[ ! -d $HOME/.local/bin ] && mkidr -p $HOME/.local/bin
	rm -rf $HOME/.local/bin/nixdbs > /dev/null 2>&1
	ln -s $NIXDBS_HOME/bin/nixdbs.sh $HOME/.local/bin/nixdbs
	if [ ! grep -q "NIXDBS_HOME" $HOME/.zshrc ]; then
		echo "# ====== NIXDBS SETTINGS ======" >> $HOME/.zshrc
		echo "" >> $HOME/.zshrc
		echo "# ====== NIXDBS SETTINGS ======" >> $HOME/.zshrc
		echo 'export NIXDBS_HOME=$HOME/.nixdbs' >> $HOME/.zshrc
		echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.zshrc
	fi
	if [ ! grep -q "NIXDBS_HOME" $HOME/.bashrc ]; then
		echo "# ====== NIXDBS SETTINGS ======" >> $HOME/.bashrc
		echo "" >> $HOME/.bashrc
		echo "# ====== NIXDBS SETTINGS ======" >> $HOME/.bashrc
		echo 'export NIXDBS_HOME=$HOME/.nixdbs' >> $HOME/.bashrc
		echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.bashrc
	fi
}


install_nixdbs
