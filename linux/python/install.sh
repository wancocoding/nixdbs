#!/usr/bin/env bash


echo "===================================================="
echo "            Installing pyenv and python!            "
echo "===================================================="

echo "======> install python3.9 by brew"

HOMEBREW_PREFIX="$(brew --prefix)"
if [ -e $HOMEBREW_PREFIX/bin/python3.9 ]; then
	brew upgrade python@3.9
else
	brew install python@3.9
fi

HOMEBREW_PREFIX="$(brew --prefix)"
$HOMEBREW_PREFIX/bin/pip3 install -U pip

# see more: https://github.com/pyenv/pyenv

echo "======> install Pyenv"

if [[ -d "$HOME/.pyenv" ]]; then
	echo "Pyenv already installed"
else
	echo "Pyenv not installed, install now..."
	brew install pyenv
fi

# pyenv envrionment
function set_pyenv_env {
	# echo "set pyenv to your startup file"
	# echo "# ====== pyenv settings ======" >> $HOME/.profile
	# echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.profile
	# echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.profile
	# echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> $HOME/.profile

	echo "# ====== pyenv settings ======" >> $HOME/.zshrc
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zshrc
	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zshrc
	echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> $HOME/.zshrc
}

if grep -qi "pyenv settings" $HOME/.zshrc >/dev/null 2>&1; then
	echo "pyenv already setup to your startup file"
else
	set_pyenv_env
fi

# 
eval "$(pyenv init -)"


echo "======> install Python Dependance"
_PY_DEPENDANCE='libssl-dev zlib1g-dev libbz2-dev '
_PY_DEPENDANCE+='libreadline-dev libsqlite3-dev llvm '
_PY_DEPENDANCE+='libncurses5-dev libncursesw5-dev '
_PY_DEPENDANCE+='xz-utils tk-dev libffi-dev liblzma-dev python-openssl'
sudo apt install $_PY_DEPENDANCE -y

echo "======> install Python version by pyenv"

_DOWNLOAD_PY_VERSION="3.8.6"
_DOWNLOAD_PY_URL="https://npm.taobao.org/mirrors/python"
_DOWNLOAD_PY_URL+="/${_DOWNLOAD_PY_VERSION}/Python-${_DOWNLOAD_PY_VERSION}.tar.xz"
# mkdir -p $HOME/.pyenv/cache >/dev/null 2>&1
if [ -d $HOME/.pyenv/versions/$_DOWNLOAD_PY_VERSION ]; then
	echo "python ${_DOWNLOAD_PY_VERSION} already installed!"
else
	wget $_DOWNLOAD_PY_URL -P $HOME/.pyenv/cache
	pyenv install $_DOWNLOAD_PY_VERSION
fi


echo "======> Change pip mirror"
mkdir -p $HOME/.pip >/dev/null 2>&1
cp ./python/pip.conf $HOME/.pip/


echo "======> Install python virualenv"
brew install pyenv-virtualenv

_PYENV_VIRTUALENV_ENV='if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi'
if grep -i "pyenv-virtualenv-init" $HOME/.zshrc >/dev/null 2>&1; then
	echo "pyenv-virtualenv already setup to your rcfile"
else
    echo $_PYENV_VIRTUALENV_ENV >> $HOME/.zshrc
fi


eval "$(pyenv virtualenv-init -)"

# pyenv global system
pyenv versions

# echo "======> Setup python envrionment for system"
# # the custome global virtual environment for neovim and system
# _PY_GLOBAL_ENV_NAME="global${_DOWNLOAD_PY_VERSION}"
# _PY_GLOBAL_PREFIX="${HOME}/.pyenv/versions/${_PY_GLOBAL_ENV_NAME}"
# _PY_GLOBAL_PIP3=$_PY_GLOBAL_PREFIX/bin/pip3
# pyenv virtualenv $_DOWNLOAD_PY_VERSION $_PY_GLOBAL_ENV_NAME
# pyenv global $_PY_GLOBAL_ENV_NAME
# 
# 
# $_PY_GLOBAL_PIP3 install -U pip
# $_PY_GLOBAL_PIP3 install pynvim
# # ranger file management
# $_PY_GLOBAL_PIP3 install ranger-fm
# 
# # list install versions
# pyenv versions


# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
