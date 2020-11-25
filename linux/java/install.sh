#!/usr/bin/env bash


echo "===================================================="
echo "            Installing Java!                        "
echo "===================================================="


_JDK_VERSION="15.0.1"
_DOWNLOAD_URL="http://files.static.tiqiua.com/cocoding/dl/softs/jdk-${_JDK_VERSION}_${_osname}-x64_bin.tar.gz"
_JDK_FOLDER="jdk-$_JDK_VERSION"

_GRADLE_VERSION="6.7"
_GRADLE_DOWNLOAD_URL="http://files.static.tiqiua.com/cocoding/dl/softs/gradle-${_GRADLE_VERSION}-all.zip"
_GRADLE_FOLDER="gradle-${_GRADLE_VERSION}"

echo "======> install oracle jdk15"

_jdk_installed=$(detect_cmd java)


if (($_jdk_installed)); then
	echo "Java already installed"
else
    mkdir -p $(pwd)/temp/ >/dev/null 2>&1
    cd ./temp

    echo $_DOWNLOAD_URL
    curl $_DOWNLOAD_URL -o jdk.tar.gz

    tar xvzf jdk.tar.gz
	mv $_JDK_FOLDER $HOME/apps/
    rm -rf ${WORKSPACEDIR}/temp/ >/dev/null 2>&1
    cd $WORKSPACEDIR
	
fi


if grep -iq 'export JAVA_HOME' $HOME/.bashrc >/dev/null 2>&1; then
	echo "java path already setup!"
else
	# echo "# ====== java settings ======" >> $HOME/.profile
	# echo "export JAVA_HOME=$HOME/apps/${_JDK_FOLDER}" >> $HOME/.profile
	# echo 'export PATH=$PATH:$JAVA_HOME/bin' >> $HOME/.profile
	
	echo "# ====== java settings ======" >> $HOME/.zshrc
	echo "export JAVA_HOME=$HOME/apps/${_JDK_FOLDER}" >> $HOME/.zshrc
	echo 'export PATH=$PATH:$JAVA_HOME/bin' >> $HOME/.zshrc
fi

export JAVA_HOME=$HOME/apps/${_JDK_FOLDER}
export PATH=$PATH:$JAVA_HOME/bin

java --version


echo "======> install gradle"


_gradle_installed=$(detect_cmd gradle)


if (($_gradle_installed)); then
	echo "Gradle already installed"
else
    mkdir -p $(pwd)/temp/ >/dev/null 2>&1
    cd ./temp

    echo $_GRADLE_DOWNLOAD_URL
    curl $_GRADLE_DOWNLOAD_URL -o gradle.zip

    unzip gradle.zip
	mv $_GRADLE_FOLDER $HOME/apps/
    rm -rf ${WORKSPACEDIR}/temp/ >/dev/null 2>&1
    cd $WORKSPACEDIR
fi

if grep -iq 'export GRADLE_HOME' $HOME/.bashrc >/dev/null 2>&1; then
	echo "gradle path already setup!"
else
	# echo "# ====== gradle settings ======" >> $HOME/.profile
	# echo "export GRADLE_HOME=$HOME/apps/${_GRADLE_FOLDER}" >> $HOME/.profile
	# echo 'export PATH=$PATH:$GRADLE_HOME/bin' >> $HOME/.profile
	
	echo "# ====== gradle settings ======" >> $HOME/.zshrc
	echo "export GRADLE_HOME=$HOME/apps/${_GRADLE_FOLDER}" >> $HOME/.zshrc
	echo 'export PATH=$PATH:$GRADLE_HOME/bin' >> $HOME/.zshrc
fi

export GRADLE_HOME=$HOME/apps/${_GRADLE_FOLDER}
export PATH=$PATH:$GRADLE_HOME/bin

gradle --version


# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
