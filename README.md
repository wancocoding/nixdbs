Coco's Dotfiles
===

Initialize a development environment on a `Linux`, `Unix`, `MacOS` system within minutes,
Contains necessary utilities and development components.

## Features

* system settings
    - timezone
    - locale
    - package manager repository mirrors
* Develop Languages
    - `Python` dev kits
    - `Java` dev kits
    - `C/C++` dev kits
    - `Golang` dev kits
    - `Node` dev kits
    - `Ruby` dev kits
* Services
    - sshd
    - proxy
* Common Tools
    - `zsh` and `ohmyzsh`
    - `Vim`
    - `Homebrew`
    - base develop libraries
    - `git` and git settings
    - other useful softs
        + `/usr/share/dict/words` for dictionary
        + standard-version (git commit tools)
        + `wget` `file` `zip` `unzip` `net-tools` `iputils-ping` `tree` `htop` `unrar` `less` `most`
          `bat` `neofetch` `lsd` `fzf` `ripgrep` `fd` `the_sliver_searcher` `netcat`

## Installation

```
curl -fsSL https://raw.githubusercontent.com/wancocoding/nixdbs/master/tools/install.sh | bash
```

### http proxy

You can define a http proxy in two ways:

add a `http_proxy` in a config file 
```
http_proxy = http://tb.cocosrv.com:9081
```

or add a `NIXDBS_HTTP_PROXY` in your bashrc or zshrc(recommend)



## Principle

* Keep Small, Simple
* Script your workflow, record every useful step to scripts.
* Manage your settings, config files, dotfiles in git repository
* Alway use the package management first`(apt|pacman|dnf|yum|apk|zypper..) > homebrew > install manually`

## Support OS

+ OS
	- [x] Linux
		* [x] Archlinux
		* [x] Ubuntu/Debain
		* [x] Gentoo
		* [x] Fedora/RedHat
		* [x] OpenSuse
	- [ ] OSX
+ Architecture
	- [x] `x86`
	- [x] `x86_64`
	- [x] `armv6l`
	- [x] `aarch64`


## Development

