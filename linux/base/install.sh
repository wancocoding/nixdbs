#!/usr/bin/env bash


echo "===================================================="
echo "            Installing Base Dependence              "
echo "===================================================="



sudo apt install git gcc make curl wget file unzip -y

echo "======> install build-essential"

sudo apt-get install build-essential -y

echo "======> init submodule"
git submodule update --init --recursive 


# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
