#!/usr/bin/env bash


echo "===================================================="
echo "            Installing Cpp Dev Env                  "
echo "===================================================="



echo "======> Install gdb-dashboard!"

wget -P ~ https://git.io/.gdbinit

HOMEBREW_PREFIX="$(brew --prefix)"
$HOMEBREW_PREFIX/bin/pip3 install pygments



# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
