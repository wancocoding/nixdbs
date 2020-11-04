#!/usr/bin/env bash

# install vim

echo "===================================================="
echo "            Installing Vim!                         "
echo "===================================================="

echo "======> install vim"

sudo apt install vim
sudo apt install vim-gtk3

echo "======> linking vimrc file"

if [[ -e "$HOME/.vimrc" ]]; then
	rm -rf $HOME/.vimrc
fi
ln -s $(pwd)/vim/vimrc.symlink $HOME/.vimrc


if [[ -d "$HOME/.vim" ]]; then
	rm -rf $HOME/.vim
fi
ln -s $(pwd)/vim/vimfiles.symlink $HOME/.vim


echo "======> init vim package"

mkdir -p $HOME/.vim/pack/colors/start/ >/dev/null 2>&1
mkdir -p $HOME/.vim/pack/default/start/ >/dev/null 2>&1

# echo "======> install vim theme"
# 
# if [[ -d $HOME/.vim/pack/colors/start/gruvbox ]]; then
# 	echo "vim theme gruvbox already installed!"
# else
# 	git submodule add https://github.com/morhetz/gruvbox.git \
# 		./vim/vimfiles.symlink/pack/colors/start/gruvbox
# fi

echo "======> install vim plugins"

if [[ -e $HOME/.vim/autoload/plug.vim ]]; then
	echo "vim-plug already installed"
else
	curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +qall!



# upgrade plugins
# git submodule update --remote --merge

# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
