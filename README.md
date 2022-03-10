Coco's Dotfiles
===

Install require softs and libraries for development environment
## Features

+ 系统进基本的初始化
  - 时区
  - 字符集
  - 软件源镜像
+ 开发环境基础
  - git和配置
  - Vim/NeoVim和配置
  - 基础工具包
+ 代理设置
+ 服务
  - sshd
  - git
+ 特定语言开发环境
  - C/C++
  - Java
  - Python
  - Golang
  - Node
  - Ruby
  - Lua
+ 其它工具
  - fzf bat lsd bat htop netcat ripgrep fd the_silver_searcher

* setup script
* dotfiles
* system settings
	- timezone
	- apt source
	- locale
* Languages
	- `Python` dev kits
	- `Java` dev kits
	- `C/C++` dev kits
	- `Golang` dev kits
	- `Node` dev kits
	- `Lua` dev kits
* Common Tools
	- `Vim/Neovim`
	- `Homebrew`
	- base libraries
	- `Tmux`
	- `git` and git settings
	- `fzf`
	- others
		+ `/usr/share/dict/words` for dictionary
		+ standard-version (git commit tools)
		+ wget file vim unzip net-tools iputils-ping tree htop unrar less most


## Principle

* Keep Small,Simple
* 尽量将工作脚本化,放到`~/sbin`里
* 尽量将配置文件用git管理起来
* 尽量使用系统自带的软件包管理器,优先级为`(apt|pacman|dnf|yum|apk|zypper..) > homebrew > install manually`

## Support OS

* Linux
    - Archlinux
    - Ubuntu
    - Alpine
    - [ ] Fedora/RedHat
    - [ ] OpenSuse
* [ ] OSX


## What's Next


