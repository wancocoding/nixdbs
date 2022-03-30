#!/bin/bash

# setup vim


# install plugin manager
# see: https://github.com/junegunn/vim-plug
vim_install_pm()
{
    if [ ! -a $HOME/.vim/autoload/plug.vim ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            "${GITHUB_PROXY}https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    fi
}
