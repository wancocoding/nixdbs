#!/usr/bin/env bash

set -Eeu

NIXDBS_REPO="https://github.com/wancocoding/nixdbs.git"
NIXDBS_REPO_DEFAULT="https://github.com/wancocoding/nixdbs.git"
NIXDBS_REPO_MIRROR_GiTEE="https://gitee.com/nexco/nixdbs.git"

NIXDBS_HOME=$HOME/.nixdbs

# check git
if ! command -v git >/dev/null 2>&1; then
	echo "you must install git first, after taht run the command again!"
	exit 1
fi
# check bash
if [ -z "${BASH_VERSION:-}" ]
then
  echo "Bash is required to interpret this script."
  exit 1
fi

if [ -d $NIXDBS_HOME ];then
	echo "nixdbs already exist!"
	echo "if you want to reinstall it, you can remove $NIXDBS_HOME manually fist"
	exit 1
fi

echo "Which repository do you want to use below?"
echo "  [a] github(default)"
echo "  [b] gitee(china)"
read -p "Which one is your choice ? [a|b]" user_input
case $user_input in
    a*|A*)
		NIXDBS_REPO=$NIXDBS_REPO_DEFAULT
		echo "use default repository(github)"
    	;;
	b*|B*)
		NIXDBS_REPO=$NIXDBS_REPO_MIRROR_GiTEE
		echo "use gitee repository"
    	;;
    *)
    	echo "use default repository(github)"
    	;;
esac

git clone $NIXDBS_REPO $NIXDBS_HOME

# installation

[ ! -d $HOME/.local/bin ] && mkdir -p $HOME/.local/bin
rm -rf $HOME/.local/bin/nixdbs > /dev/null 2>&1
ln -s $NIXDBS_HOME/bin/nixdbs.sh $HOME/.local/bin/nixdbs
if ! grep -q "NIXDBS_HOME" $HOME/.zshrc; then
	echo "" >> $HOME/.zshrc
	echo "# ====== NIXDBS SETTINGS ======" >> $HOME/.zshrc
	echo 'export NIXDBS_HOME=$HOME/.nixdbs' >> $HOME/.zshrc
	echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.zshrc
fi
if ! grep -q "NIXDBS_HOME" $HOME/.bashrc; then
	echo "" >> $HOME/.bashrc
	echo "# ====== NIXDBS SETTINGS ======" >> $HOME/.bashrc
	echo 'export NIXDBS_HOME=$HOME/.nixdbs' >> $HOME/.bashrc
	echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.bashrc
fi

echo "Install nixdbs finish! now restart your shell and run [nixdbs]"

