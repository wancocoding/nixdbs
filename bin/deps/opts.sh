#!/usr/bin/env bash

declare -a INSTALL_TASK_NAME_ARRAY=(osmir sys proxy base git dev_tools \
	brew zsh ohmyzsh vim dev_basic \
	tldr cheatsh \
	java python clang ruby node go)

declare -a UPDATE_TASK_NAME_ARRAY=(sys base git dev_tools \
	brew zsh ohmyzsh vim \
	tldr cheatsh)

print_help()
{
    cat <<-EndOptionsHelp
Usage: nixdbs [-chv] info|update [task name]|run [task name]
Options:
    -c, --config [file]             Define a cofiguration file
    -f, --force                     Force install or update
    -h, --help                      Display this help
    -v, --version                   Display Nixdbs version

Actions:
    info                Show nixdbs information on this machine
    init                Init system and install packages defined in configuration files
    install [tasks]     Run the specified task
    update  [tasks]     Update all(when task is empty), or update specified task 
    remove  [tasks]     Remove specified task 

Install Tasks:
    osmir               setup system package manager mirror
    proxy               setup http_proxy
    sys                 sync system repository and update system
    base                some necessary packages
    git                 git
    homebrew            setup Homebrew
    dev_tools           useful tools like fzf fd ripgrep unzip htop neofetch 
    tldr                tldr
    cheatsh             cheat.sh
    zsh                 zsh
    ohmyzsh             ohmyzsh
    vim                 vim
    ruby                rbenv and default ruby version
    java                sdkman, default jdk and gradle
    node                nvm and default node version
    clang               llvm make cmake ninja etc.
    pydeps              install packages that depends on when compile python
    python              pyenv, pyenv-virtualenv and default python3
    go                  golang

Update Tasks:
    sys                 system sync and update
    base                necessary packages, curl wget ...
    git                 git
    tools               useful tools like fzf fd ripgrep unzip htop neofetch 
    tldr                tldr
    cheatsh             cheat.sh
    zsh                 zsh
    ohmyzsh             ohmyzsh
    vim                 vim


Example Usage:
    nixdbs init
    - This command will install run all tasks defined in the configuration file
    nixdbs -c mini init
    - This command will run init task by a mini configuration file
    nixdbs -c ~/.nixdbs.my.conf init
    - This command will run init task by a user-defined configuration file
    nixdbs ins vim
    - Install vim and some vim plugins
    nixdbs ins vim git brew
    - Install vim git and homebrew
    nixdbs update brew
    - Update homebrew
    nixdbs info
    - Show nixdbs information on this machine
    nixdbs remove node
    - Remove nvm and nodejs installed by nvm

EndOptionsHelp
}

declare -a specified_steps=()

# run mode -  force: default 1
NIXDBS_RUN_MODE_FORCE=0

# USER_CONFIG_FILE="$NIXDBS_HOME/configs/nixdbs.default.conf"

define_main_job()
{
	if [ -z ${JOB_NAME:-} ];then
		JOB_NAME="$1"
	else
		echo "Error: You can only run one job at a time!"
		exit 1
	fi
}

add_task()
{
	if [ ${JOB_NAME} = "install" ];then
		if [[ " ${INSTALL_TASK_NAME_ARRAY[*]} " =~ " ${1} " ]]; then
			specified_steps+=("$1")
			return 0
		else
			echo "Error: Installation task or argument [${1}] not found!"
			return 1
		fi
	elif [ ${JOB_NAME} = "update" ]; then
		if [[ " ${UPDATE_TASK_NAME_ARRAY[*]} " =~ " ${1} " ]]; then
			specified_steps+=("$1")
			return 0
		else
			echo "Error: Installation task or argument [${1}] not found!"
			return 1
		fi
	elif [ ${JOB_NAME} = "remove" ]; then
		REMOVE_TASK_NAME="$1"
	fi
}

while [[ $# -gt 0 ]]
do
	run_arg="$1"
	case $run_arg in
		init)
			define_main_job "init"
			shift
			;;
		up|update)
			define_main_job "update"
			shift
			;;
		ins|install)
			define_main_job "install"
			shift
			;;
		rm|remove)
			define_main_job "remove"
			shift
			;;
		info|information)
			define_main_job "info"
			shift
			;;
		-c|--config)
			[ -z ${2:-} ] && \
				echo "Abort. Your must add a task name argument." && \
				exit 1
			USER_CONFIG_FILE="$2"
			shift 2
			;;
		-f|--force)
			# force mode enable
			NIXDBS_RUN_MODE_FORCE=0
			shift
			;;
		-h|--help)
			print_help
			exit 0
			;;
		-v|--version)
			print_version
			exit 0
			;;
		*)
			if add_task "$1" ; then
				shift
			else
				print_help
				exit 1
			fi
			;;
	esac
done


# 
if [ ! -z ${USER_CONFIG_FILE:-} ]; then
	case $USER_CONFIG_FILE in
		mini)
			JOB_CONFIG_FILE="$NIXDBS_HOME/configs/nixdbs.minimal.conf"
			;;
		full)
			JOB_CONFIG_FILE="$NIXDBS_HOME/configs/nixdbs.full.conf"
			;;
		default)
			JOB_CONFIG_FILE="$NIXDBS_HOME/configs/nixdbs.default.conf"
			;;
		*)
			if [[ "$USER_CONFIG_FILE" = /* ]]; then
				# absolute path
				if [ ! -f $USER_CONFIG_FILE ];then
					echo "File: ${USER_CONFIG_FILE} does not exist."
					exit 1
				else
					JOB_CONFIG_FILE=$USER_CONFIG_FILE
				fi
			else
				USER_CONFIG_FILE=${USER_CONFIG_FILE#\./}
				USER_CONFIG_FILE="$CURRENT_WORK_PATH/${USER_CONFIG_FILE}"
				if [ ! -f $USER_CONFIG_FILE ]; then
					echo "File: ${USER_CONFIG_FILE} does not exist."
					exit 1
				else
					JOB_CONFIG_FILE=$USER_CONFIG_FILE
				fi
			fi
			;;
	esac
else
	JOB_CONFIG_FILE="$NIXDBS_HOME/configs/nixdbs.default.conf"
fi

echo "================================================================================="
echo "Task Information                "
echo "job name:           $JOB_NAME"
echo "tasks:              ${specified_steps[@]}"
echo "config file:        ${JOB_CONFIG_FILE}"
echo "================================================================================="

