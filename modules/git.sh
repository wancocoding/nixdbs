#!/usr/bin/env bash

# make sure the git package has already installed
# eg: apt install git, emerge -av dev-vcs/git, pacman -Sy git, apk add git ...

# git-shell setup
sudo /bin/bash -c "grep -q 'git-shell' /etc/shells || sudo echo '/usr/bin/git-shell' >> /etc/shells"

# add git user
sudo id -u git &>/dev/null || sudo useradd -m -s $(which git-shell) -U git

# create authorized_keys
sudo -u git /bin/bash -c "mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys &>/dev/null && chmod 600 ~/.ssh/authorized_keys"


# config git
sudo -u git /bin/bash -c "git config --global init.defaultBranch master"


# create repository
read -p "Do you want to create git repository? [y|n]" user_input
case $user_input in
    Y*|y*)
	read -p "enter repository name: " user_input
	sudo -u git /bin/bash -c "cd ~ && mkdir ${user_input}.git && cd ${user_input}.git && git init --bare"
    	;;
    *)
    	echo "Skip create repository..."
    	;;
esac

# add ssh keys
read -p "Do you want to add user ssh key? [y|n]" user_input

case $user_input in
    Y*|y*)
	read -p "enter your ssh key : " user_input
	sudo -u git /bin/bash -c "echo $user_input >> ~/.ssh/authorized_keys"
    	;;
    *)
    	echo "Skip add ssh key..."
    	;;
esac

unset user_input

# vim:set ft=bash et sts=4 ts=4 sw=4:
