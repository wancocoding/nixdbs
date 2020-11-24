#!/usr/bin/env bash

echo "===================================================="
echo "            Installing RVM and ruby!                "
echo "===================================================="

_RB_DEFAULT_VERSION="2.7.2"
HOMEBREW_PREFIX="$(brew --prefix)"

echo "======> install ruby for system tools like vim!"
brew install ruby
$HOMEBREW_PREFIX/bin/gem sources --add https://mirrors.tuna.tsinghua.edu.cn/rubygems/ \
	--remove https://rubygems.org/
$HOMEBREW_PREFIX/bin/gem sources -l
$HOMEBREW_PREFIX/bin/gem list

echo "======> setup gemrc"
rm -rf $HOME/.gemrc &>/dev/null
cp -uv ruby/gemrc $HOME/.gemrc


echo "======> install RVM"

if [[ -d "$HOME/.rvm" ]]; then
	echo "RVM already installed"
else
	echo "RVM not installed, install now..."
	# curl -sSL https://get.rvm.io | bash
	source ruby/rvm-install.sh
fi


if grep -qi "Load RVM" $HOME/.bashrc >/dev/null 2>&1; then
	echo "rvm already setup to your startup file"
else
	echo "rvm not setup to your startup file please do it yourself!"
	echo "# Load RVM into a shell session *as a function*" >> $HOME/.zshrc
	echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> $HOME/.zshrc
fi

source $HOME/.bashrc

rvm -v

echo "======> install ruby version"

# sed -i 's!ftp.ruby-lang.org/pub/ruby!ruby.taobao.org/mirrors/ruby!' $HOME/.rvm/config/db
sed -i 's!cache.ruby-lang.org/pub/ruby!cache.ruby-china.com/pub/ruby!' $HOME/.rvm/config/db
source $HOME/.rvm/scripts/rvm
rvm install "$_RB_DEFAULT_VERSION"
rvm list

# rvm use "$_RB_DEFAULT_VERSION" --default
# 
# 
# echo "======> install gemset"
# 
# # rvm gemset create neovim
# 
# # rvm use "${_RB_DEFAULT_VERSION}@neovim"
# 
# gem sources -–remove https://rubygems.org/
# gem sources --add https://gems.ruby-china.com/
# # gem sources -a http://ruby.taobao.org/
# gem source -l
# 
# gem install neovim

# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
