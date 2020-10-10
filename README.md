# Wancocoding's dotfiles


Maintainer:		Vincent Wancocoding  <http://www.cocoding.cc>
Version:		0.2
created:		2020-10-01
updated:		2020-10-10


This project is used to record my develop envrionment on osx win and linux


# Content

* [Intro](#intro)
* [Installation Windows](#installation-windows)
	- Preparation before installation
	- 
	- [Vim](#vim-nvim)
	- After Installation
		+ ssh key configuration
* [Installation Linux](#installation-linux)
* [Installation OSX](#installation-OSX)
* [ChangeLog](#changelog)


# Intro

This dotfiles project contains the following content

* OSX
	- brew
	- Vim & NeoVim
	- zsh & oh-my-zsh
	- git
	- tmux
	- node & nvm
	- python & pyenv
	- java
	- go
* Windows
	- chocolatey
	- Vim & NeoVim
	- git
* Linux

# Installation Windows



## VIM-NVIM




## After Install Nvim


```
:call mkdir(stdpath('config'), 'p')
:exe 'edit '.stdpath('config').'/init.vim'
```


## ZSHRC




# ChangeLog

* 2020-10-10 v0.2
	- create windows config
	- nvim and vim use the save config
	- update readme
* 2020-10-01 v0.1
	- create repository
