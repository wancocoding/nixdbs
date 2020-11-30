#!/usr/bin/env bash

_VIM_VERSION="8.2.2020"
_DOWNLOAD_URL="http://files.static.tiqiua.com/cocoding/dl/softs/vim-${_VIM_VERSION}.tar.gz"

HOMEBREW_PREFIX="$(brew --prefix)"

echo "===================================================="
echo "            Installing Vim!                         "
echo "===================================================="


echo "======> install vim"

# remove all vim
sudo apt remove vim vim-gtk3
brew uninstall vim



# _vim_installed=$(detect_cmd vim)

if [ -s $HOME/apps/bin/vim ]; then
	echo "Vim already installed"
else
    echo "======> compiling a vim for myself!"

    # source $HOME/.rvm/scripts/rvm
    # rvm use 2.7.2 --default
    # pyenv global system
    rvm use system
    nvm use system

    echo "install dependence"

    sudo apt install libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev -y

    echo "======> download vim source!"

    mkdir -p $(pwd)/temp/ >/dev/null 2>&1

    cd ./temp

    echo $_DOWNLOAD_URL
    curl $_DOWNLOAD_URL -o vim.tar.gz

    tar xvzf vim.tar.gz
    cd vim-${_VIM_VERSION}

    # export CFLAGS="-I$HOME/.pyenv/versions/3.8.6/include/python3.8 -I${HOME}/.rvm/rubies/ruby-2.7.2/include/ruby-2.7.0"
    # export LDFLAGS="-L${HOME}/.rvm/rubies/ruby-2.7.2/lib"
    ./configure --with-features=huge \
                --with-tlib=ncurses \
                --enable-multibyte \
                --enable-rubyinterp=yes \
                --enable-python3interp=yes \
                --enable-perlinterp=yes \
                --enable-luainterp=yes \
                --enable-gtk3-check \
                --enable-gui=gtk3 \
                --enable-terminal \
                --enable-cscope \
                --with-x \
                --enable-gnome-check \
                --with-gnome \
                --prefix=$HOME/apps

		# --with-python3-command=$HOME/.pyenv/versions/global3.8.6/bin/python3 \
		# --with-ruby-command=$HOME/.rvm/rubies/ruby-2.7.2/bin/ruby \

    make
    make install

    rm -rf ${WORKSPACEDIR}/temp/ >/dev/null 2>&1
    cd $WORKSPACEDIR
fi


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


$HOME/apps/bin/vim +PlugInstall


$HOME/apps/bin/vim -c ":CocInstall coc-tsserver coc-eslint coc-json \
coc-prettier coc-css coc-vimlsp coc-go coc-python coc-clangd coc-cmake \
coc-bookmark coc-explorer"

# upgrade plugins
# git submodule update --remote --merge


echo "======> Install Neovim"

echo "======> install pynvim(py) neovim(rb) for Neovim"
$HOMEBREW_PREFIX/bin/pip3 install pynvim
$HOMEBREW_PREFIX/bin/gem install neovim
$HOMEBREW_PREFIX/bin/npm install -g neovim

brew install neovim

mkdir -p $HOME/.config/nvim 2>/dev/null

if [[ -e "$HOME/.config/nvim/init.vim" ]]; then
	rm -rf $HOME/.config/nvim/init.vim
fi
ln -s $(pwd)/vim/init.vim.symlink $HOME/.config/nvim/init.vim


# vim:set ft=sh et sts=4 ts=4 sw=4 tw=78:
