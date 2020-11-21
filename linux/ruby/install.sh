#!/usr/bin/env bash

echo "===================================================="
echo "            Installing RVM and ruby!                "
echo "===================================================="


echo "======> install RVM"

if [[ -d "$HOME/.rvm" ]]; then
	echo "RVM already installed"
else
	echo "RVM not installed, install now..."
	# curl -sSL https://get.rvm.io | bash
	source ruby/rvm-install.sh
fi


if grep -qi "LOAD RVM" $HOME/.profile >/dev/null 2>&1; then
	echo "rvm already setup to your startup file"
else
	echo "rvm not setup to your startup file please do it yourself!"
fi

source $HOME/.profile

rvm -v

echo "======> install ruby version"

# sed -i 's!ftp.ruby-lang.org/pub/ruby!ruby.taobao.org/mirrors/ruby!' $HOME/.rvm/config/db
sed -i 's!cache.ruby-lang.org/pub/ruby!cache.ruby-china.com/pub/ruby!' $HOME/.rvm/config/db
rvm install 2.7.2
rvm list
rvm use 2.7.2 --default


echo "======> install gemset"

rvm gemset create neovim

rvm use 2.7.2@neovim

gem sources -–remove https://rubygems.org/
gem sources --add https://gems.ruby-china.com/
# gem sources -a http://ruby.taobao.org/
gem source -l

gem install neovim

# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
