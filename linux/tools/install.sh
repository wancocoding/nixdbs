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
git config --global diff.tool vimdiff
git config --global alias.d difftool
git config --global difftool.prompt false
git config --global difftool.trustExitCode true

echo "======> install peek for record screen"
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek -y

echo "======> install some tools by brew"
echo "htop screenfetch tree ctags xclip ... etc"
brew install htop glances screenfetch tree xclip bat fzf \
	ripgrep fd the_silver_searcher \
	ranger \
	neovim \
	hugo

# universal-catgs required
# Deprecated, not use ctags any more, use LSP instead
# brew install python@3.8
# brew install --HEAD universal-ctags/universal-ctags/universal-ctags

echo "======> Set these tools installed by brew"
# fzf init
$(brew --prefix)/opt/fzf/install
# ranger init
ranger --copy-config=all


echo "======> install ossutil"
_OSSUTIL_DOWNLOAD_URL="http://gosspublic.alicdn.com/ossutil/1.6.19/ossutil64"
curl $_OSSUTIL_DOWNLOAD_URL -o $HOME/apps/bin/ossutil
chmod 755 $HOME/apps/bin/ossutil
$HOME/apps/ossutl update


# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
