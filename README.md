Coco's Dotfiles
===

Initialize a development environment on a `Linux`, `Unix`, `MacOS` system within minutes,
Contains necessary utilities and development components.

## Features

* system settings
	- timezone
    - locale
	- repository mirrors
* Develop Languages
	- `Python` dev kits
	- `Java` dev kits
	- `C/C++` dev kits
	- `Golang` dev kits
	- `Node` dev kits
	- `Lua` dev kits
    - `Ruby` dev kits
* Services
    - sshd
    - git
    - proxy
* Common Tools
	- `Vim/Neovim`
	- `Homebrew`
	- base develop libraries
	- `Tmux`
	- `git` and git settings
	- `fzf`
	- others
		+ `/usr/share/dict/words` for dictionary
		+ standard-version (git commit tools)
		+ wget file unzip net-tools iputils-ping tree htop unrar less most
          bat neofetch lsd fzf ripgrep fd the_sliver_searcher netcat


## Principle

* Keep Small, Simple
* Script your workflow
* Manage your settings, config files, dotfiles in git repository
* Alway use the package management that in the system first, `(apt|pacman|dnf|yum|apk|zypper..) > homebrew > install manually`

## Support OS

* Linux
    - [x] Archlinux
    - [x] Ubuntu
    - [x] Alpine
    - [ ] Fedora/RedHat
    - [ ] OpenSuse
* [ ] OSX


## Development

### Workflow

* edit code
* git add file
* git commit with template
* standard-version, or `standard-version -r major|minor|patch|1.1.1`
* git push --follow-tags github master

## Problems

* [ ] can't close issue from commit
