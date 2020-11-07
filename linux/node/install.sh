#!/usr/bin/env bash


echo "===================================================="
echo "            Installing Nvm and Node!                "
echo "===================================================="


echo "======> install Nvm"


_NVM_ENV_LINE1='export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' 
_NVM_ENV_LINE2='[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'

if [[ -d "$HOME/.nvm" ]]; then
	echo "Nvm already installed"
else
	echo "Nvm not installed, install now..."
	source ./node/nvm-install.sh
fi



# check nvm envrionment
if [ -e "$HOME/.profile" ]; then
	if cat $HOME/.profile|grep -i "export NVM_DIR" >/dev/null 2>&1; then
		echo "nvm already setup to your profile"
	else
		echo $_NVM_ENV_LINE1 >> $HOME/.profile
		echo $_NVM_ENV_LINE2 >> $HOME/.profile
	fi
else
	echo $_NVM_ENV_LINE1 >> $HOME/.profile
	echo $_NVM_ENV_LINE2 >> $HOME/.profile
fi

# set mirrors

if cat $HOME/.profile|grep -i "export NVM_NODEJS_ORG_MIRROR" >/dev/null 2>&1; then
	echo 'nvm mirror already setup'
else
	echo 'export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node' >> $HOME/.profile
fi

# refresh envrionment
source $HOME/.profile



echo "======> install node versions"

nvm install  --lts=erbium


nvm use default

npm config set registry https://registry.npm.taobao.org

nvm ls


# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
