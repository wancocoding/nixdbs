#!/usr/bin/env bash


echo "===================================================="
echo "            Installing Nvm and Node!                "
echo "===================================================="


echo "======> install node by brew"
brew install node

echo "======> install Nvm"


_NVM_ENV_LINE1='export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' 
_NVM_ENV_LINE2='[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
_NVM_ENV_LINE3='[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'

if [[ -d "$HOME/.nvm" ]]; then
	echo "Nvm already installed"
else
	echo "Nvm not installed, install now..."
	source ./node/nvm-install.sh
fi

function set_nvm_env {
	# echo "# ====== NVM settings ======" >> $HOME/.profile
	# echo $_NVM_ENV_LINE1 >> $HOME/.profile
	# echo $_NVM_ENV_LINE2 >> $HOME/.profile
	# echo $_NVM_ENV_LINE3 >> $HOME/.profile

	echo "# ====== NVM settings ======" >> $HOME/.zshrc
	echo $_NVM_ENV_LINE1 >> $HOME/.zshrc
	echo $_NVM_ENV_LINE2 >> $HOME/.zshrc
	echo $_NVM_ENV_LINE3 >> $HOME/.zshrc
}

# check nvm envrionment
if grep -i "export NVM_DIR" $HOME/.profile >/dev/null 2>&1; then
	echo "nvm already setup to your profile"
else
	set_nvm_env
fi

# set mirrors

echo "======> set nvm mirror"
if cat $HOME/.zshrc|grep -i "export NVM_NODEJS_ORG_MIRROR" >/dev/null 2>&1; then
	echo 'nvm mirror already setup'
else
	echo 'export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node' >> \
		$HOME/.zshrc
fi

source $HOME/.nvm/nvm.sh

echo "======> install node versions"

nvm install  --lts=fermium


# nvm use default


echo "======> set npm mirror"
HOMEBREW_PREFIX="$(brew --prefix)"

$HOMEBREW_PREFIX/bin/npm config set registry https://registry.npm.taobao.org

$HOMEBREW_PREFIX/bin/npm install -g yarn


# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
