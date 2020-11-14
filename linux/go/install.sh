#!/usr/bin/env bash


echo "===================================================="
echo "            Installing Golang!                      "
echo "===================================================="


echo "======> install Go"

brew install go


if grep -iq 'export GOPATH' $HOME/.profile >/dev/null 2>&1; then
	echo "go path already setup!"
else
	echo "# ====== golang settings ======" >> $HOME/.profile
	echo 'export GOPATH=$HOME/develop/Go' >> $HOME/.profile
	echo 'export GO111MODULE=auto' >> $HOME/.profile
	echo 'export GOPROXY=https://goproxy.cn,direct' >> $HOME/.profile
	echo 'export PATH="$PATH:$GOPATH/bin"' >> $HOME/.profile
	
	echo "# ====== golang settings ======" >> $HOME/.zshrc
	echo 'export GOPATH=$HOME/develop/Go' >> $HOME/.zshrc
	echo 'export GO111MODULE=auto' >> $HOME/.zshrc
	echo 'export GOPROXY=https://goproxy.cn,direct' >> $HOME/.zshrc
	echo 'export PATH="$PATH:$GOPATH/bin"' >> $HOME/.zshrc
fi

source $HOME/.profile


echo "======> install Go modules"

mkdir -p $HOME/develop/go >/dev/null 2>&1

# go get -u google.golang.org/grpc
# go get -u github.com/gin-gonic/gin



# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:


