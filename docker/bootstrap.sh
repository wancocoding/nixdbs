#!/bin/bash

set -eu;


# =================================
# soft link dotfiles
# =================================

# get current path
WORKDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
DOTFILES=".config .pip .fzf.zsh .fzf.bash .gemrc .zshrc .tmux.conf .tmux .gitconfig
.p10k.zsh"
for dotfile in $DOTFILES; do
	rm -rf "$HOME/${dotfile}"
	ln -s "$WORKDIR/${dotfile}" "$HOME/${dotfile}"
done
# rm -rf $HOME/.zshrc 
# rm -rf $HOME/.gitconfig 
# rm -rf $HOME/.tmux 
# rm -rf $HOME/.tmux.conf
# rm -rf $HOME/.fzf.zsh
# rm -rf $HOME/.p10k.zsh
# rm -rf $HOME/.pip
# rm -rf $HOME/.gemrc
# ln -s $WORKDIR/.gitconfig $HOME/
# ln -s $WORKDIR/.zshrc  $HOME/
# ln -s $WORKDIR/.fzf.zsh $HOME/
# ln -s $WORKDIR/.tmux.conf $HOME/
# ln -s $WORKDIR/.tmux $HOME/
# ln -s $WORKDIR/.pip $HOME/
# ln -s $WORKDIR/.p10k.zsh $HOME/
# ln -s $WORKDIR/.gemrc $HOME/

# vim:set ft=sh noet sts=4 sw=4 ts=4 tw=78:
